Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130648AbRCEGv5>; Mon, 5 Mar 2001 01:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130656AbRCEGvs>; Mon, 5 Mar 2001 01:51:48 -0500
Received: from albatross.prod.itd.earthlink.net ([207.217.120.120]:23543 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130648AbRCEGvf>; Mon, 5 Mar 2001 01:51:35 -0500
Message-ID: <022f01c0a540$b7366820$0a25a8c0@wizardess.wiz>
From: "J. Dow" <jdow@earthlink.net>
To: "Miles Lane" <miles@megapathdsl.net>,
        "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <3AA27137.3020600@megapathdsl.net>
Subject: Re: Linux on the Unisys ES7000 and CMP2 machines?
Date: Sun, 4 Mar 2001 22:41:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Miles Lane" <miles@megapathdsl.net>

> I noticed that this article mentions that Unisys has
> no plans to port Linux to it's "cellular multiprocessor"
> machines.  So, I am wondering if anyone is working
> on this independantly.

Miles, if these babies are the 32 processor monsters that UniSys
has been making recently there IS interest to get Linux on it.
But the people I know who have mentioned "interest", mostly from
a curiosity standpoint, have their hands neatly tied by Microsoft.
Ya see, the developers at UniSys have NT source licenses so they
can develop the HALs for the monsters. Microsoft insists that they
spend a considerable time away from OS development before working
on another OS. So, no Linux port is in the offing, I suspect. The
people who KNOW the machine are not allowed to do it. And I can
guarantee you that the machines are not well documented at the
level a person making an NT port would need. (As an aside it seems
the UniSys guys know more about how to debug HALs without fancy
ICEs than the MS guys. At least the amount of travel between
Mission Viyoyo and Redmond suggests it.)

{^_^}   Joanne "Too many years in a DoD environment" Dow, who has
        put a whole string of two's together to figure out the
        above from clues laid by her HAL developer partner.
        jdow@earthlink.net


