Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUGXSBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUGXSBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 14:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUGXSBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 14:01:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64457 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261724AbUGXSBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 14:01:09 -0400
Subject: Re: [FC1], 2.6.8-rc2 kernel, new motherboard problems
From: Lee Revell <rlrevell@joe-job.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4102530C.8060604@gmx.net>
References: <Pine.LNX.4.44.0407211334260.3000-100000@mail.birdvet.org>
	 <200407240158.56434.gene.heskett@verizon.net>
	 <1090649207.1006.12.camel@mindpipe>
	 <200407240520.31906.gene.heskett@verizon.net>  <4102530C.8060604@gmx.net>
Content-Type: text/plain
Message-Id: <1090692070.845.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 14:01:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 08:16, Carl-Daniel Hailfinger wrote:
> Gene Heskett schrieb:
> 
> > On Saturday 24 July 2004 02:06, Lee Revell wrote:

> >>>>Wow, nVidia won't release the specs for a *10/100 ethernet
> >>>>controller*? Having to reverse engineer a network driver is
> >>>>ridiculous in this day and age.  I can understand binary-only
> >>>>graphics drivers, there is a lot of valuable IP in there, but
> >>>>this is a freaking network card.  What do they expect people to
> >>>>do?
> >>>>
> >>>>Maybe some bad press would set them straight.
> >>>>
> >>>>Lee
> 
> Could you please check the facts (or ask the driver authors) before
> suggesting to haunt NVidia with bad press? Thanks.
> 

All the facts I needed to know were in the original post.  You had to
reverse engineer a network driver because Nvidia would not release
specs.  We should not be having to reverse engineer a 10/100 ethernet
controller in 2004.  The Linux community should make noise when vendors
do this.
 
> > I'm under the impression the forcedeth writers did have access to this 
> > data.  Is this incorrect? The question is directed at the forcedeth 
> > authors.  If you are one, then please clarify.
> 
> I am one of the authors. We did not have any information in the first
> place, but now that our reverse engineered driver works well, NVidia
> contributed bugfixes and gigabit support to our driver.

This is pretty shoddy on their part.  Like I said, I can understand not
wanting to release the specs for their GFX cards, but a freaking 10/100
ethernet controller is ridiculous.

Lee


