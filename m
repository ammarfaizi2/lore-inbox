Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266565AbSKZTZG>; Tue, 26 Nov 2002 14:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSKZTZG>; Tue, 26 Nov 2002 14:25:06 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266565AbSKZTY7>;
	Tue, 26 Nov 2002 14:24:59 -0500
Date: Mon, 25 Nov 2002 22:34:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, alan@redhat.com
Subject: Re: A new Athlon 'bug'.
Message-ID: <20021125213447.GB12236@elf.ucw.cz>
References: <200211211556.gALFunG3014402@noodles.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211211556.gALFunG3014402@noodles.internal>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Very recent Athlons (Model 8 stepping 1 and above) (XPs/MPs and mobiles)
> have an interesting problem.  Certain bits in the CLK_CTL register need
> to be programmed differently to those in earlier models. The problem arises
> when people plug these new CPUs into boards running BIOSes that are unaware
> of this fact.

What happens when bit is programed wrongly?

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
