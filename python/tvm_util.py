from typing import Optional

import torch
import torchvision
import tvm
from tqdm import tqdm
from tvm.contrib import graph_executor, utils

import torch_util


def test_tvm(
    lib: tvm.runtime.Module,
    dataset: torchvision.datasets.VisionDataset,
    host: Optional[str] = None,
    port: int = 9090,
):
    tmp = utils.tempdir()
    lib_fname = tmp.relpath("net.tar")
    lib.export_library(lib_fname)

    if host is not None:
        remote = tvm.rpc.connect(host, port)
    else:
        remote = tvm.rpc.LocalSession()

    remote.upload(lib_fname)
    rlib = remote.load_module("net.tar")

    dev = remote.cpu(0)
    module = graph_executor.GraphModule(rlib["default"](dev))

    dataloader = torch.utils.data.DataLoader(dataset, batch_size=1)

    top1 = 0
    top5 = 0

    with tqdm(dataloader, desc=f"[Test {len(dataset)} img") as pbar:
        for i, (images, labels) in enumerate(pbar):
            module.set_input("input", images.numpy())
            module.run()
            preds = module.get_output(0).numpy()
            preds = torch.from_numpy(preds)
            acc1, acc5 = torch_util.accuracy(preds, labels, topk=(1, 5))
            top1 += acc1[0]
            top5 += acc5[0]
            pbar.set_postfix(
                {
                    "Top1": top1 / (i + 1),
                    "Top5": top5 / (i + 1),
                }
            )

