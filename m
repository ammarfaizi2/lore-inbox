Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSJYNDX>; Fri, 25 Oct 2002 09:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbSJYNDX>; Fri, 25 Oct 2002 09:03:23 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:60900 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261390AbSJYNDX>; Fri, 25 Oct 2002 09:03:23 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
References: <20021025103631.GA588@giantx.co.uk>
	<20021025103938.GN4153@suse.de>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Fri, 25 Oct 2002 15:09:17 +0200
In-Reply-To: <20021025103938.GN4153@suse.de> (Jens Axboe's message of "Fri,
 25 Oct 2002 12:39:38 +0200")
Message-ID: <87adl2is1u.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens!

* Jens Axboe writes:
>2.5.44 and thus 2.5.44-acX has seriously broken REQ_BLOCK_PC, so it's
>no wonder that it breaks hard. Alan, I can sync the sgio patches for
>you if you want.

>Nyk, if you could try
>*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-15.bz2
>that would be great, thanks.

Is this the patch Jörg Schilling was testing to get DMA with the new
dev=/dev/hd* interface working? I just did some tests. Audio CD ripping
worked just fine. When I try to burn a CD I get a kernel panic. Are you
intersted in further results?

regards
Markus

