Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136775AbREIRm6>; Wed, 9 May 2001 13:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136781AbREIRms>; Wed, 9 May 2001 13:42:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55312 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136775AbREIRm1>; Wed, 9 May 2001 13:42:27 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ECN: Volunteers needed
Date: 9 May 2001 10:41:59 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9dbvh7$amg$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0105091559260.27312-100000@netcore.fi> <Pine.LNX.4.21.0105091249520.23642-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0105091249520.23642-100000@scotch.homeip.net>
By author:    God <atm@sdk.ca>
In newsgroup: linux.dev.kernel
> 
> Agreed.  For now ECN has been disabled here.  I got tired of so many sites
> not supporting it that I gave up.  Maybe by 2.8.x kernels it will be worth
> turning back on.  Thats not to say however that I don't like what the ECN
> people are trying to do, rather its causing me more grief with it on, then
> the grief I get with it off.
> 

I suspect that the main way to get this thing fixed is to make sure
ECN is enabled on the server side; for example, we have turned on ECN
on kernel.org.  If a user is using a broken software stack, it's their
loss, not ours.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
