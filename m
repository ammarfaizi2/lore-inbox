Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262169AbREXQS7>; Thu, 24 May 2001 12:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262175AbREXQSu>; Thu, 24 May 2001 12:18:50 -0400
Received: from fornax.elf.stuba.sk ([147.175.111.112]:49933 "EHLO
	fornax.elf.stuba.sk") by vger.kernel.org with ESMTP
	id <S262169AbREXQSj>; Thu, 24 May 2001 12:18:39 -0400
Date: Thu, 24 May 2001 18:18:36 +0200 (CEST)
From: Marek Zelem <marek@fornax.elf.stuba.sk>
To: <linux-kernel@vger.kernel.org>
Subject: ANNOUNCE: e2salvage, Ext2 repairing utility
Message-ID: <Pine.LNX.4.31.0105241424400.19700-100000@fornax.elf.stuba.sk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I announce the ext2 filesystem repairing utility, e2salvage.

e2salvage is a utility which tries to recover a data from damaged ext2
filesystems. Unlike e2fsck, it does not look for the data at particular
places and it don't tend to believe the data it finds; thus  it can handle
much more damaged filesystem. Moreover, fsck connects the found i-nodes to
lost+found directory. e2salvage instead tries to recover the directory
structure.

You can download the package at http://project.terminus.sk/e2salvage/ .

					Marek Zelem
--
  e-mail: marek@fornax.elf.stuba.sk
          marek@terminus.sk
  web: http://fornax.elf.stuba.sk/~marek/
  pgp key: http://fornax.elf.stuba.sk/~marek/gpg.txt




