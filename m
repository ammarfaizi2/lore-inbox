Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317826AbSGKMeN>; Thu, 11 Jul 2002 08:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317830AbSGKMeM>; Thu, 11 Jul 2002 08:34:12 -0400
Received: from hermes8.atos-group.com ([160.92.18.57]:51979 "EHLO
	hermes8.segin.com") by vger.kernel.org with ESMTP
	id <S317826AbSGKMeM>; Thu, 11 Jul 2002 08:34:12 -0400
Message-ID: <8D7D56C6ED3DD411998D009027DC685E04664E76@srv-grp-s1.segin.com>
From: =?iso-8859-1?Q?Brasseur_Val=E9ry?= <Valery.Brasseur@atosorigin.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: kernel hang on reading /proc/<pid>/stat
Date: Thu, 11 Jul 2002 14:36:55 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running kernel 2.4.18 + SGI xfs 1.1 + Trond NFS patch +
ext2_get_block_blk_removal on bi-PIII SMP kernel (Compaq DL360) with 4Gb
memory

the ps -ef hang in reading /proc/<pid>/stat after displaying some of the
process.

top & vmstat hang too !

the rest of process continue to run OK !

the machine was up for 1 week before this ! and now it's 2 time in 4 hour
which it does this !


NB : look like "ps -ax hang with Mozilla in 2.4.9" but I am on a 2.4.18 !!
but don't find how it have been corrected to check !

any help would be appreciated !
valery
