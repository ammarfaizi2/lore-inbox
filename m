Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTK2Hef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 02:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263703AbTK2Hef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 02:34:35 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:6335
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S263700AbTK2Hed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 02:34:33 -0500
Date: Fri, 28 Nov 2003 23:36:44 -0800
To: Shawn Willden <shawn-lkml@willden.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APM Suspend Problem
Message-ID: <20031129073643.GA27452@nasledov.com>
References: <20031127062057.GA31974@nasledov.com> <20031129021712.GA13798@nasledov.com> <20031129022005.GE8039@holomorphy.com> <200311282238.21420.shawn-lkml@willden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311282238.21420.shawn-lkml@willden.org>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strange. My laptop always suspended just fine with any number of PCMCIA cards
in it and even with the power cord plugged in. Now that you mention it, though,
I don't think I've tried suspending it unplugged; I will try this as soon as
possible, but I think the laptop should suspend without the power cord
proviso..

On Fri, Nov 28, 2003 at 10:38:18PM -0700, Shawn Willden wrote:
> On Friday 28 November 2003 07:20 pm, William Lee Irwin III wrote:
> > There is an oddity I forgot to report: it doesn't suspend when I close
> > the lid if I still have the power plugged in. Also, I tried the suspend
> > button, and it works perfectly fine here for both suspend and resume on
> > a standard LTC issue Stinkpad T21, again with the power cord proviso.
> 
> Do you also have a PCMCIA card in the slot?
> 
> I've always found that my Thinkpads (about three different models, 
> currently a T21) will not suspend with power connected and a PCMCIA card 
> in.  If I remove either power or my PC cards, then closing the lids will 
> trigger a suspend.
> 
> I stumbled across something a while back that indicated this was a Thinkpad 
> BIOS bug, but I have no idea if that is correct.

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
