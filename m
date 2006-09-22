Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWIVFdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWIVFdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWIVFdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:33:16 -0400
Received: from solarneutrino.net ([66.199.224.43]:21253 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932283AbWIVFdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:33:15 -0400
Date: Fri, 22 Sep 2006 01:33:12 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: Stephen Olander Waters <swaters@luy.info>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net, davej@codemonkey.org.uk
Subject: Re: R200 lockup (was Re: DRI/X error resolution)
Message-ID: <20060922053312.GG16939@tau.solarneutrino.net>
References: <1158898988.3280.8.camel@ix> <20060922043801.GE16939@tau.solarneutrino.net> <1158900841.3280.12.camel@ix> <20060922051622.GF16939@tau.solarneutrino.net> <21d7e9970609212229v1f8f490dx71c6d1abb104400c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d7e9970609212229v1f8f490dx71c6d1abb104400c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 03:29:48PM +1000, Dave Airlie wrote:
> On 9/22/06, Ryan Richter <ryan@tau.solarneutrino.net> wrote:
> >On Thu, Sep 21, 2006 at 11:54:01PM -0500, Stephen Olander Waters wrote:
> >> Here is the bug I'm working from (includes hardware, software, etc.):
> >> https://bugs.freedesktop.org/show_bug.cgi?id=6111
> >>
> >> DRI will work if you set: Option "BusType" "PCI" ... but that's not a
> >> real solution. :)
> 
> I really think this more AGP related a bug in the driver for the VIA
> AGP chipsets what AGP chipset are you guys using?

AMD 8151 here.  I have yet to try Option "BusType" "PCI", so I can't say
if that works here (it'll be a week or so before I have a chance to
try).

-ryan
