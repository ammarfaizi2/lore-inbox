Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbSJBUhy>; Wed, 2 Oct 2002 16:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbSJBUhy>; Wed, 2 Oct 2002 16:37:54 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:59063 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262574AbSJBUhw>;
	Wed, 2 Oct 2002 16:37:52 -0400
Date: Wed, 2 Oct 2002 22:40:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ralf Gerbig <rge-news@dialeasy.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 input drivers Synaptics touchpad
Message-ID: <20021002224030.A21833@ucw.cz>
References: <200210021824.54927@hsp-law.de> <20021002204428.A20378@ucw.cz> <200210022222.57408@hsp-law.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210022222.57408@hsp-law.de>; from rge-news@dialeasy.de on Wed, Oct 02, 2002 at 10:22:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 10:22:56PM +0200, Ralf Gerbig wrote:
> Hi Vojtech,
> 
> Am Mittwoch, 2. Oktober 2002 20:44 schrieb Vojtech Pavlik:
> > On Wed, Oct 02, 2002 at 06:24:54PM +0200, Ralf Gerbig wrote:
> > > Hi Vojtech,
> > >
> > > I just tried 2.5.40 and could not get the Synaptics touchpad on an Acer
> > > Travelmate 353 to work with either the synaptics driver for XFree
> > > at http://www.mobilix.org/software/synaptics/ or tpconfig at
> > > http://www.compass.com/synaptics/ gpm also does not like the synps2
> > > protocol. Works as (im)ps/2 though.
> 
> > Yes, for 2.5 I still have to write a synaptics touchpad kernel driver
> > for it to work properly.
> 
> is there any kind of 'raw' psaux interface to those userspace drivers?
> looks to me as a, at least stopgap, solution. With the disclamer that
> I know nothing about the interface or the kernel, but i've read the
> mantra 'userspace' many times (for values of userspace as in X and gpm).

No, there isn't, but it should not be too hard to implement. Maybe
easier than a synaptics driver, but not really much easier.

-- 
Vojtech Pavlik
SuSE Labs
