Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280328AbRJaRWW>; Wed, 31 Oct 2001 12:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280326AbRJaRWN>; Wed, 31 Oct 2001 12:22:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37136 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S280321AbRJaRWH>; Wed, 31 Oct 2001 12:22:07 -0500
Date: Wed, 31 Oct 2001 12:16:26 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: submit-linux-dev-kernel@ns1.yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <Pine.LNX.4.33.0110251222090.25423-100000@viper.haque.net>
Message-ID: <Pine.LNX.3.96.1011031121150.24635G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Oct 2001, Mohammad A. Haque wrote:

> On Thu, 25 Oct 2001, bill davidsen wrote:
> 
> > I haven't seen any problem, either. Certainly not with fdisk, this is
> > what I see:
> > ================================================================
> > bilbo:root> hdparm -V
> > hdparm v3.9
> >
> > bilbo:root> df
> > ....
> >
> > Don't know if this sheds light on the topic, I certainly do run fdisk on
> > "drives" my RAID controller creates which have 600GB or so broken into
> > little 100GB files.
> 
> I guess it was unclear at first. You'll only get the error when you run
> mke2fs.

I still am missing this, obviously after I partition the drive I do mke2fs
so I can use the partition. I don't see what sequence you follow which
triggers this, can you clarify?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

