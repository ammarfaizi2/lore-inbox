Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284927AbRLPXcS>; Sun, 16 Dec 2001 18:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284928AbRLPXcI>; Sun, 16 Dec 2001 18:32:08 -0500
Received: from r-fi057-2-388.tin.it ([62.211.53.132]:16389 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S284927AbRLPXcD>; Sun, 16 Dec 2001 18:32:03 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Is /dev/shm needed?
In-Reply-To: <E16FkV9-00010E-00@DervishD.viadomus.com>
	<1008544328.843.0.camel@phantasy>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 17 Dec 2001 00:31:53 +0100
In-Reply-To: <1008544328.843.0.camel@phantasy>
Message-ID: <877krm68t2.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Robert" == Robert Love <rml@tech9.net> writes:



    > See Documentation/filesystems/tmpfs.txt for more information.


There's no such file in my tree... what version are you talking about? 

ik5pvx@penny:/usr/src/linux/Documentation/filesystems $ ls
00-INDEX  bfs.txt     ext2.txt     ncpfs.txt  smbfs.txt    umsdos.txt
Locking   coda.txt    fat_cvf.txt  ntfs.txt   sysv-fs.txt  vfat.txt
adfs.txt  cramfs.txt  hpfs.txt     proc.txt   udf.txt      vfs.txt
affs.txt  devfs       isofs.txt    romfs.txt  ufs.txt
ik5pvx@penny:/usr/src/linux/Documentation/filesystems $ head ../../Makefile 
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 16
EXTRAVERSION =

Pf

-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.16 #1 Fri Nov 30 22:12:51 CET 2001 i686 unknown
