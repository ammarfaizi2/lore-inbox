Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVCJGJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVCJGJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 01:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVCJGF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 01:05:59 -0500
Received: from avmta3-rme.xtra.co.nz ([210.86.15.158]:21958 "EHLO
	avmta3-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S262297AbVCIUcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:32:19 -0500
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C330360F9B4@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: Srihari Vijayaraghavan <harisri@internode.on.net>,
       Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Bug: ll_rw_blk.c, elevator.c and displaying "default" IO Sche
	dule 	r at boot-time (Cosmetic only)
Date: Thu, 10 Mar 2005 09:32:00 +1300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens/Hari,

The patch which you both supplied does solve the problem.

I'd imagine this patch is probably not "critical" enough for a
2.6.11.x-series patch, but it would be nice to see this included in 2.6.12.

Thanks!

James Roberts-Thomson
----------
A synonym is a word you use if you can't spell the other one.
 
LKML Readers:  Please ignore the following disclaimer (automatically
attached by my work email gateway).  This email is explicitly declared to be
non confidential and does not contain privileged information.


This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
