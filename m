Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268960AbTCDBjZ>; Mon, 3 Mar 2003 20:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbTCDBjY>; Mon, 3 Mar 2003 20:39:24 -0500
Received: from hera.cwi.nl ([192.16.191.8]:997 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268960AbTCDBjY>;
	Mon, 3 Mar 2003 20:39:24 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 4 Mar 2003 02:49:30 +0100 (MET)
Message-Id: <UTC200303040149.h241nUR02366.aeb@smtp.cwi.nl>
To: greg@kroah.com, mdharm-usb@one-eyed-alien.net, mmoneta@optonline.net
Subject: [PATCH] Re: [Fwd: Re: SDDR-09]
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    From mmoneta@optonline.net  Mon Mar  3 20:08:12 2003

    The 2.4 support has been available since April of 2002:
    http://www.kernel.org/pub/linux/kernel/people/aeb

    It was announced on the kernel mailing list, and doesn't seem to have
    gotten any negative feedback, but it never became part of the kernel.
    It appears to work, and many people say it works.

    Apparently, this patch to support SDDR09 write capability was never
    submitted.  Are there any plans to do so?

I just fetched this patch again, rediffed against 2.4.21-pre5
booted and verified that I could write a file. This version
lives in .../kernel/people/aeb/sddr09-driver-for-2.4.21pre5 .

Greg, Matt: probably this driver was never submitted. Let me do it now.

Andries
