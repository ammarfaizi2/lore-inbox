Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUHIMM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUHIMM4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUHIMLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:11:45 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:15825 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266511AbUHIMLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:11:04 -0400
Date: Mon, 9 Aug 2004 14:10:13 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091210.i79CADsf009661@burner.fokus.fraunhofer.de>
To: mj@ucw.cz, torvalds@osdl.org
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Linus Torvalds <torvalds@osdl.org>
>>
>> Most of all, I would like to know (I see I'm repeating myself, but I still
>> haven't seen an answer to that) what's so special about the SCSI-like devices,

>Don't even bother.

>Joerg is wrong. SCSI number simply doesn't work, and the current Linux 
>setup is absolutely the right thing to do.

Discussions are based on exchanging arguments.......

It seems that Linus is just trying to prove that he still has no arguments.
Wouln't it be wise for him to stay quiet instead of wasting other people's time?

He should takle an advise, spend 5 minutes on something useful and fix the show 
stopper bugs in /usr/src/linux/include/scsi/sg.h & 
/usr/src/linux/include/scsi/scsi.h

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
