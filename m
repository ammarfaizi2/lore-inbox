Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSGASkj>; Mon, 1 Jul 2002 14:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSGASkh>; Mon, 1 Jul 2002 14:40:37 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:12267 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S313687AbSGASkd>;
	Mon, 1 Jul 2002 14:40:33 -0400
Date: Mon, 1 Jul 2002 20:42:57 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal
Message-ID: <20020701184257.GC1762@localhost>
Mail-Followup-To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 01 July 2002, at 13:48:55 -0400,
Bill Davidsen wrote:

> The suggestion was made that kernel module removal be depreciated or
> removed. I'd like to note that there are two common uses for this
> capability, and the problems addressed by module removal should be kept in
> mind. These are in addition to the PCMCIA issue raised.
> 
>From my non-kernel non-programmer point of view, module removal can be
useful under more circunstances than the ones you said. For example,
trying some combination of parameters for a module to get you damned
piece of hardware working, and having to reboot each time you want to
pass it a different set of parameters, doesn't seem reasonable to me.
Examples such as network cards (as Bill said), your nice TV capture
card, or just setting a "debug=1" for a module that seems not to be
working OK.

Except there was a way to pass parameters to modules once loaded, and
have them "reconfigure" themselves for the new parameters.

Just the opinion of a Linux user :)

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
