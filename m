Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSK0CO7>; Tue, 26 Nov 2002 21:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSK0CO7>; Tue, 26 Nov 2002 21:14:59 -0500
Received: from bitmover.com ([192.132.92.2]:43711 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264617AbSK0CO6>;
	Tue, 26 Nov 2002 21:14:58 -0500
Date: Tue, 26 Nov 2002 18:22:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: Thomas Molina <tmolina@copper.net>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.5 problem with SMC2632W adapter
Message-ID: <20021126182210.C24374@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Thomas Molina <tmolina@copper.net>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
References: <Pine.LNX.4.44.0211261926230.964-100000@lap.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211261926230.964-100000@lap.molina>; from tmolina@copper.net on Tue, Nov 26, 2002 at 08:06:39PM -0600
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 08:06:39PM -0600, Thomas Molina wrote:
> I've previously written about my problems getting the above wireless 
> PCMCIA network card working with 2.5.  Since Alan seems to have added some 
> network and cardbus changes I tried 2.5.49-ac2.  I'm getting the same 
> symptoms.  Thus far, in addition to 2.5.49-ac2 I've tried 2.5.49 (latest 
> bk), 2.5.48, 2.5.47, 2.4.18-18.8.0 (RedHat), and 2.4.19.  

In the "for what it is worth" department, I have this card too as well as
an Orinoco, and I've never gotten the SMC card to work under recent kernels.
The weird thing is that I distinctly remember it working once upon a time.
So we've regressed as far as I can tell.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
