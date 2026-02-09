# Vitis Embedded
This folder is created to test out the new Vitis Embedded tool.

## Invoking Vitis Python CLI

vitis -i

## Vitis Python Commands

client = vitis.create_client()

help(client)

client.set_workspace("./workspace")

platform = client.create_platform_component(name = "standalone_plat", hw = "../implement/results/top.xsa", cpu = "psu_cortexa53_0", os = "standalone", domain_name = "standalone_a53")


## Subsequent Sessions

vitis -s setup.py

vitis --workspace ./workspace




