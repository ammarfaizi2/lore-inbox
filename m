Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271578AbTGQWYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271601AbTGQWYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:24:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55304 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271578AbTGQWXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:23:42 -0400
Date: Thu, 17 Jul 2003 18:31:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Deepak Saxena <dsaxena@mvista.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David griego <dagriego@hotmail.com>,
       alan@storlinksemi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
In-Reply-To: <20030714215321.GA22061@xanadu.az.mvista.com>
Message-ID: <Pine.LNX.3.96.1030717182339.17023A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Deepak Saxena wrote:

> On Jul 14 2003, at 21:34, Alan Cox was caught saying:
> > 
> > You don't have to. You can go build and test and maintain a set of TOE patches.
> > Nobody is stopping you. Lots of Linux code exists because someone decided that
> > the official story was wrong and proved it so.
> 
> Alan,
> 
> I agree with your basic sentiment, but the issue here is that supporting
> TOE requires changes that are very intimate to the kernel. This is not
> like developing I2O which is an edge driver layer, but a core portion
> of the kernel.  Some support from the community is going to be needed. 
> Currently, any time someone mentions the idea of discussing a TOE 
> interface, it's shot down as being evil and bad. 
> 
> /me thinks that the HW vendors that really want TOE support need
>  to fund some Linux networking folks to go look at the problem
>  in detail.

My impression is that they have looked at the problem and think it's evil
and bad. Or perhaps more accurately, impractical and undesirable.

Based on my slight understanding, I think that doing TOE would require
vast changes in the way the kernel passes data and status, and given that
2.6 is a butterfly clawing its way out of the cocoon, there's no way a
major change is going to be made until 2.7.

I'm not suggesting that people will like the idea better then, but at
least the concept of major change might not be rejected, no matter what
the change might be.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

