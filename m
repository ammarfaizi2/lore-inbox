Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSKWWMc>; Sat, 23 Nov 2002 17:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbSKWWMc>; Sat, 23 Nov 2002 17:12:32 -0500
Received: from flora.INS.CWRU.Edu ([129.22.8.235]:54493 "EHLO
	flora.INS.cwru.edu") by vger.kernel.org with ESMTP
	id <S265139AbSKWWMb>; Sat, 23 Nov 2002 17:12:31 -0500
Date: Sat, 23 Nov 2002 17:20:57 -0500
From: Justin Hibbits <jrh29@po.cwru.edu>
To: linux-kernel@vger.kernel.org
Subject: FWD: Re: ps2 mouse remapping keyboard
Message-ID: <20021123222057.GB125@lothlorien.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm an idiot for not CC'ing to the lkml, so here's my reply to Randy.

Thanks,

Justin 

----- Forwarded message from Justin Hibbits <jrh29@po.cwru.edu> -----

Date: Sat, 23 Nov 2002 17:18:41 -0500
From: Justin Hibbits <jrh29@po.cwru.edu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: ps2 mouse remapping keyboard
In-Reply-To: <20021123140810.6738d073.rddunlap@osdl.org>
User-Agent: Mutt/1.4i

On Sat, Nov 23, 2002 at 02:08:10PM -0800, Randy.Dunlap wrote:
> On Sat, 23 Nov 2002 16:12:47 -0500 Justin Hibbits <jrh29@po.cwru.edu> wrote:
> 
> | I'm not subscribed right now, but I have a major problem.  For some reason,
> | sometimes when I startup either gpm or X, my keyboard gets remapped, so that
> | several of the keys return keycode 0x70 or 0x71, while others return 0x56, and
> | the rest return extended e0/e1 keycodes.  I'm unsure why this happens.  It
> | started happening when I installed dri drivers off dri.sf.net, but even after
> | removing those drivers, deleting the kernel source tree, and starting from
> | scratch, it still happens.  I'm at a loss, so if someone can shed some light on
> | this, I'd be grateful.
> | this happens sporadically, so not exactly sure what the problem is.  Hopefully
> | this won't happen when I get a USB mouse/keyboard for christmas :) /me crosses
> | fingers.
> 
> No idea, but you seem to think that it's software, but
> could it be a cable problem?
> 
> BTW, the main reason that I'm replying is that you gave no clues
> about what versions of software you are using.
> 
> --
> ~Randy
> 

I apologize for forgetting to give you the details.  I thought I had, but, oh
well...here they are (if you need more, just tell me).


I'm using gpm 1.20.0, and X 4.2.0 (earliest X that supports radeon 8500).  I'm
using kernel 2.4.18, and it also happens w/ kernel 2.4.19.  If you want me to
give you my .config file for the kernel, I can.

As for the hardware side, I have a microsoft intellimouse ps2, which worked for
about 15 months, and still does work sometimes, and I've also tried with a
microsoft trackball which is known good.  My motherboard is Asus A7V266-E, but
I'm not using RAID, and I have a KeyTronic keyboard, and the proc is
AthlonXP1800+, w/ 512MB RAM.  Dunno how much this helps you, but I hope at
least a little.

Thanks,
Justin Hibbits

-- 
Registered Linux user 260206

"One World, One Web, One Program"
	- Microsoft Promo Ad
"Ein Volk, Ein Reich, Ein Fuhrer"
	- Adolf Hitler

I'm not paranoid.  They really *are* out to get me!

----- End forwarded message -----

-- 
Registered Linux user 260206

"One World, One Web, One Program"
	- Microsoft Promo Ad
"Ein Volk, Ein Reich, Ein Fuhrer"
	- Adolf Hitler

I'm not paranoid.  They really *are* out to get me!

