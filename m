Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262909AbRE1CPl>; Sun, 27 May 2001 22:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262910AbRE1CPb>; Sun, 27 May 2001 22:15:31 -0400
Received: from hongkong.com ([202.84.12.153]:35830 "HELO hongkong.com")
	by vger.kernel.org with SMTP id <S262909AbRE1CPY>;
	Sun, 27 May 2001 22:15:24 -0400
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Message-ID: <09989471898799.08184@mail1.hongkong.com>
Date: Mon, 28 May 2001 10:12:00 +0800 (CST)
From: antonpoon@hongkong.com
To: linux-kernel@vger.kernel.org
Subject: Problems Configurating NFS
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to config my RedHat7.0 computer to run NFS server, I have edited the exports file, and turned on portmap and NFS, but there were some problems as follows, how can I fix it?

Starting system logger: [ OK ]
Starting kernel logger: [ OK ]
Starting portmapper: [ OK ]
Starting NFS file locking services:
Starting NFS lockd: portmap: server localhost not responding, timed out
portmap: server localhost not responding, timed out
lockd_up: makesock failed, error=-5
portmap: server localhost not responding, timed out
lockdsvc: Input/output error
[FAILED]
Starting NFS statd: [ OK ]
Starting up APM daemon: [ OK ]
Initializing random number generator: [ OK ]
Mounting NFS filesystems: mount: can't get address for server
[FAILED]
Mounting other filesystems: [MS-DOS FS Rel. 12,FAT 16,check=n,conv=b,uid=0,gid=0,umask=022,bmap]
[me=0x7e,cs=756,#f=16,fs=62548,fl=193668,ds=3292308,de=4734,data=3292608,se=5246,ts=2116189728,ls=3198,rc=0,fc=4294967295]
Transaction block size = 512
VFS: Can't find a valid MSDOS filesystem on dev 03:05.
mount: wrong fs type, bad option, bad superblock on /dev/hda5,


I wish to be personally CC'ed the answers/comments posted to the list in response to my posting. Thank you.

Thanks,
Anton
----------------------------------------------
 歡迎使用HongKong.com郵件系統
 Thank you for using hongkong.com Email system

