Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTANUhF>; Tue, 14 Jan 2003 15:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbTANUhF>; Tue, 14 Jan 2003 15:37:05 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:53600 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S265246AbTANUhD>; Tue, 14 Jan 2003 15:37:03 -0500
Message-ID: <3E2476FF.1010306@blue-labs.org>
Date: Tue, 14 Jan 2003 15:45:51 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BusLogic error handling, 2.5
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 905; timestamp 2003-01-14 15:45:54, message serial number 726172
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

scsi: ***** BusLogic SCSI Driver Version 2.1.16 of 18 July 2002 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
ERROR: SCSI host `BusLogic' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c0214949>] scsi_register+0x69/0x28c
 [<c0214ba6>] scsi_register_host+0x3a/0x90
 [<c010502c>] init+0x0/0x144
 [<c0105049>] init+0x1d/0x144
 [<c010502c>] init+0x0/0x144
 [<c0107021>] kernel_thread_helper+0x5/0xc


Just a reminder.

Thank you,
David

- -- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+JHb/74cGT/9uvgsRAnj4AKDieaYovweK6Rq6LX+dpjomPiX0SgCg0drz
VU2HZ1AoaSQwdnr99VycVhI=
=ljCs
-----END PGP SIGNATURE-----

