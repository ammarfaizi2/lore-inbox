Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279814AbRK1St3>; Wed, 28 Nov 2001 13:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRK1StI>; Wed, 28 Nov 2001 13:49:08 -0500
Received: from tikal.fb10.TU-Berlin.DE ([130.149.138.229]:12672 "EHLO
	tikal.fb10.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S279798AbRK1Ss4>; Wed, 28 Nov 2001 13:48:56 -0500
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: patch-2.5.1-pre2 ide-cdrom bug
Message-Id: <E1699mH-0000GU-00@tikal.fb10.tu-berlin.de>
From: erasmo perez <erasmo@tikal.fb10.tu-berlin.de>
Date: Wed, 28 Nov 2001 19:49:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

i think there is a bug in this patch
when i trie to open the cdrom bay with cdcd open, i get:
ioctl -1 returned
and when i use cdcd close, nothing happens
also, when i try to see some dvd, xine can not read the drive (cannot read
dev/dvd)

everything works ok with the previous (pre1) patch

greetings

erasmo
