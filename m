Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290059AbSAWUgf>; Wed, 23 Jan 2002 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290060AbSAWUgZ>; Wed, 23 Jan 2002 15:36:25 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:20565 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290059AbSAWUgR>; Wed, 23 Jan 2002 15:36:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Wed, 23 Jan 2002 21:36:10 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201232018530.2202-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201232018530.2202-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020123203611.32A3F1479@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Also follow up to my success message befor in this thread]

On Wednesday, 23. January 2002 20:21, Daniel Nofftz wrote:
> On Wed, 23 Jan 2002, Martin Eriksson wrote:
> > Problems (in Windows, with similar patches) have mostly been sound skips
> > and general "skippy" behaviour (not the peanut butter). My VIA KT133
> > based mobo with Athlon 1000 had major sound skips, both with onboard VIA
> > sound and SB512. Also the graphics in most 3D games stuttered badly.

Oups. Just tried vlc and indeed: skippy sound and picture loss after 
switching to fullscreen :( Also uncommon delays on startup noticable.

Will revert it for now (vlc is more important:).

Hans-Peter

> this is the first time i hear about such problems ...
> i have no problems at all and it works great under linux and win 2k
> (vcool) ... there are no sound skips or skippy behaviors ...
>
> daniel
>
> # Daniel Nofftz
> # Sysadmin CIP-Pool Informatik
> # University of Trier(Germany), Room V 103
> # Mail: daniel@nofftz.de
