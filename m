Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUCIT3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUCIT00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:26:26 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:54961 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262134AbUCITXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:23:01 -0500
Date: Tue, 9 Mar 2004 11:22:52 -0800
From: Lee Howard <faxguy@howardsilvan.com>
To: linux-kernel@vger.kernel.org
Subject: error compiling 2.6.3
Message-ID: <20040309192252.GG11378@bilbo.x101.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

....
   UPD     include/linux/compile.h
   CC      init/version.o
   CC      init/do_mounts.o
   CC      init/do_mounts_rd.o
   CC      init/do_mounts_initrd.o
   LD      init/mounts.o
   CC      init/initramfs.o
   LD      init/built-in.o
   HOSTCC  usr/gen_init_cpio
   CPIO    usr/initramfs_data.cpio
   GZIP    usr/initramfs_data.cpio.gz
   AS      usr/initramfs_data.o
/tmp/ccFjeWhS.s: Assembler messages:
/tmp/ccFjeWhS.s:3: Error: Unknown pseudo-op:  `.incbin'
make[1]: *** [usr/initramfs_data.o] Error 1
make: *** [usr] Error 2
[root@bilbo linux-2.6.3]# 
