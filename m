Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277205AbRJDSxu>; Thu, 4 Oct 2001 14:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277207AbRJDSxl>; Thu, 4 Oct 2001 14:53:41 -0400
Received: from spruce.woods.net ([166.70.175.33]:14313 "HELO a.smtp.woods.net")
	by vger.kernel.org with SMTP id <S277205AbRJDSx3>;
	Thu, 4 Oct 2001 14:53:29 -0400
Date: Thu, 4 Oct 2001 12:30:44 -0600 (MDT)
From: "Christopher E. Brown" <cbrown@woods.net>
To: <hps@intermeta.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <9ph3qu$g9b$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.31.0110041227340.29191-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Henning P. Schmiedehausen wrote:
>
> Does it finally do speed and duplex auto negotiation with Cisco
> Catalyst Switches? Something I never ever got to work with various 2.0
> and 2.2 drivers, mode settings, Catalyst settings, IOS versions and
> almost anything else that I ever tried.
>
> 	Regards
> 		Henning


	Lets be fair here, while there are issues with some brands of
tulip card, Cisco is often to blame as well.  There are known issues
with N-WAY autoneg on many Ciscos, switches *and* routers.

