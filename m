Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWFZBCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWFZBCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWFZBCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:02:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25487 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965107AbWFZA7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:30 -0400
Date: Sun, 25 Jun 2006 17:58:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 41/43] Miscellaneous utilities for klibc
Message-Id: <klibc.200606251757.41@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] Miscellaneous utilities for klibc

A collection of minor utilities for klibc.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 6c2ddf4b91c2c390ef4568c02204f0af26fae842
tree 5bb5e3fcb63ea7a253f3ea9a4686223d540be4ad
parent f0b65bb7d198f7bde27107c762d4ff0bf43754b2
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:59:01 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:59:01 -0700

 usr/utils/Kbuild       |   62 ++++++
 usr/utils/cat.c        |  329 ++++++++++++++++++++++++++++++
 usr/utils/chroot.c     |   25 ++
 usr/utils/dd.c         |  533 ++++++++++++++++++++++++++++++++++++++++++++++++
 usr/utils/false.c      |    4 
 usr/utils/file_mode.c  |  143 +++++++++++++
 usr/utils/file_mode.h  |    1 
 usr/utils/halt.c       |   55 +++++
 usr/utils/insmod.c     |  140 +++++++++++++
 usr/utils/ln.c         |   77 +++++++
 usr/utils/minips.c     |  508 ++++++++++++++++++++++++++++++++++++++++++++++
 usr/utils/mkdir.c      |  150 ++++++++++++++
 usr/utils/mkfifo.c     |   71 ++++++
 usr/utils/mknod.c      |   58 +++++
 usr/utils/mount_main.c |  105 +++++++++
 usr/utils/mount_opts.c |   94 ++++++++
 usr/utils/mount_opts.h |   21 ++
 usr/utils/nuke.c       |  134 ++++++++++++
 usr/utils/pivot_root.c |   19 ++
 usr/utils/sleep.c      |   25 ++
 usr/utils/true.c       |    4 
 usr/utils/umount.c     |   45 ++++
 usr/utils/uname.c      |  154 ++++++++++++++
 23 files changed, 2757 insertions(+), 0 deletions(-)

Patch suppressed due to size (64 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/41-miscellaneous-utilities-for-klibc.patch
