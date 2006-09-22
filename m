Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWIVFQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWIVFQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWIVFQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:16:24 -0400
Received: from solarneutrino.net ([66.199.224.43]:19205 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932279AbWIVFQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:16:24 -0400
Date: Fri, 22 Sep 2006 01:16:22 -0400
To: Stephen Olander Waters <swaters@luy.info>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: R200 lockup (was Re: DRI/X error resolution)
Message-ID: <20060922051622.GF16939@tau.solarneutrino.net>
References: <1158898988.3280.8.camel@ix> <20060922043801.GE16939@tau.solarneutrino.net> <1158900841.3280.12.camel@ix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1158900841.3280.12.camel@ix>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 11:54:01PM -0500, Stephen Olander Waters wrote:
> Here is the bug I'm working from (includes hardware, software, etc.):
> https://bugs.freedesktop.org/show_bug.cgi?id=6111
> 
> DRI will work if you set: Option "BusType" "PCI" ... but that's not a
> real solution. :)

Oh, wow.  I had no idea there was a workaround.  What kind of
performance hit does that entail?  R200 performance is pretty dismal to
begin with, but it would be awfully nice to not have all our
workstations crashing all the time...

I wonder why that works.  What chipset do you use?  All our machines are
AMD 8151.

I'm about to leave town for several days, but I'll try that when I
return.

Cheers,
-ryan
