Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284139AbRLMPNR>; Thu, 13 Dec 2001 10:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284147AbRLMPNH>; Thu, 13 Dec 2001 10:13:07 -0500
Received: from mustard.heime.net ([194.234.65.222]:62174 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284139AbRLMPMv>; Thu, 13 Dec 2001 10:12:51 -0500
Date: Thu, 13 Dec 2001 16:12:26 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] RAID sub system / tux
In-Reply-To: <Pine.LNX.4.33.0112131008140.13419-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0112131611250.26174-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> there is no problem with single-stream IO load.  period.

I'm aware of that.

> there is also no problem with multi-stream mixed (realistic) IO loads,
> since dbench is widely run.  I'm guessing there's something specific
> to your all-read, many-stream load that noone else has ever tested,
> for obvious reasons.

Well. Someone had to do it. I hope this can be fixed. I really really want
to replace the M$ boxes we use for this today.

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

