Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318867AbSHWPzM>; Fri, 23 Aug 2002 11:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318869AbSHWPzM>; Fri, 23 Aug 2002 11:55:12 -0400
Received: from smtp01.web.de ([194.45.170.210]:1297 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318867AbSHWPzM>;
	Fri, 23 Aug 2002 11:55:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Fri, 23 Aug 2002 17:57:53 +0200
In-Reply-To: <200208231046.g7NAk2914276@devserv.devel.redhat.com> (Alan
 Cox's message of "Fri, 23 Aug 2002 06:46:02 -0400 (EDT)")
Message-ID: <87d6s9a7pa.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

* Alan Cox writes:
>The HP merge is now down to 3503 lines pending
>IDE status
>	Chasing two reports of strange ide-scsi crashes

As the problem still exists with this version, I fiddled a bit with
different kernel option. I realized that the problem only occurs, when
I have DMA enabled. As soon as I disable it, I can mount CD-ROM/DVDs
without the formerly reported kernel oops.

Hope it helps
regards
Markus

