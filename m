Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUACRig (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 12:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUACRif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 12:38:35 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62615 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263607AbUACRie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 12:38:34 -0500
Date: Sat, 3 Jan 2004 18:38:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] psmouse option parsing
Message-ID: <20040103173825.GA22082@ucw.cz>
References: <200401030350.43437.dtor_core@ameritech.net> <200401030400.55755.dtor_core@ameritech.net> <20040103100739.GB499@ucw.cz> <200401031229.25315.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401031229.25315.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 12:29:23PM -0500, Dmitry Torokhov wrote:

> On Saturday 03 January 2004 05:07 am, Vojtech Pavlik wrote:
> > On Sat, Jan 03, 2004 at 04:00:54AM -0500, Dmitry Torokhov wrote:
> > > +			[HW,MOUSE] Controls Logitech smartscroll autoreteat,
> > > +			0 = disabled, 1 = enabled (default).
> >
> > Ha, a typo. :)
> 
> Darn! :)
> 
> Sorry about that. I uploaded hand-corrected patch to 
> 
> http://www.geocities.co/dt_or/input/2_6_0-rc1/ 
> 
> and also sending it here for your reference.
> 
> Dmitry

Patch is OK now. The first (i8042 reset) patch is also OK, I misread it
when I thought I've found problems there.

Andrew, please apply these patches to your tree and/or
schedule them for inclusion into mainline.

Good work, Dmitry!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
