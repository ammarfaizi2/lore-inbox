Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317321AbSFGTAt>; Fri, 7 Jun 2002 15:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317323AbSFGTAs>; Fri, 7 Jun 2002 15:00:48 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:13780 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S317321AbSFGTAs>; Fri, 7 Jun 2002 15:00:48 -0400
Message-ID: <043e01c20e55$eafaa8e0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200206061848.UAA19403@harpo.it.uu.se>
Subject: Re: [BUG] dd, floppy, 2.5.18
Date: Fri, 7 Jun 2002 15:02:49 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mikael Pettersson" <mikpe@csd.uu.se>
> The floppy driver got broken in 2.5.13. Please try the following patch:
> http://www.csd.uu.se/~mikpe/linux/patches/2.5/patch-fix-floppy-2.5.20
> It works for me and at least one other person.

Applied to 2.5.18 (had to apply hunk #3 by hand). It fixes the
problem. Thanks.

..Stu


