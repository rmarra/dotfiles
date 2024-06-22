#!/usr/bin/env python

from git import Repo
import os


WORKSPACE_DIR = "/home/rmarra/vaults/personal"

repository = Repo(WORKSPACE_DIR)



def list_files(repository):
    index_diff = repository.index.diff(None)
    for diff in index_diff:
        yield diff.a_path
    for f in repository.untracked_files:
        yield f


def is_daily_empty(file_path):
    with open(f"{WORKSPACE_DIR}/{file_path}", "r") as f:
        c = 0
        main_content_count = 0
        for line in f:
            stripped_line = line.strip()
            if main_content_count > 1:
                return False
            elif stripped_line == "---":
                c += 1
            elif c >= 2 and stripped_line:
                main_content_count += 1
        return main_content_count <= 1


def is_daily_file(file_path):
    return "/dailies/" in file_path

for f in list_files(repository):
    to_add = []
    if is_daily_file(f) and is_daily_empty(f):
        print(f"FILE IS EMPTY: {WORKSPACE_DIR}/{f}")
        os.remove(f"{WORKSPACE_DIR}/{f}")
    to_add.append(f)
    if to_add:
        repository.index.add(to_add)
        repository.index.commit("sync obsidian files")
        repository.git.push("origin", "master")

# print(is_empty("loggi/dailies/2024-05-17.md"))
