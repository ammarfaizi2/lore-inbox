Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSDMXqk>; Sat, 13 Apr 2002 19:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSDMXqj>; Sat, 13 Apr 2002 19:46:39 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:42891 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311262AbSDMXqi>; Sat, 13 Apr 2002 19:46:38 -0400
Date: Sat, 13 Apr 2002 17:46:34 -0600
Message-Id: <200204132346.g3DNkYt09482@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
In-Reply-To: <20020413220800.GA4283@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. A. Magallon writes:
> 
> On 2002.04.13 Richard Gooch wrote:
> >H. Peter Anvin writes:
> >> Richard Gooch wrote:
> >> > 
> >> > Actually, there is some impedance matching. I've seen monitors with
> >> > hi/lo impedance switches. And I've used 15 m long high-quality VGA
> >> > cables. The result has been pretty good.
> >> > 
> >> 
> >> The best I've seen is to use Sun D-sub coax or plain coax inputs on
> >> the monitors that have them.  Those are impedance matched and can be
> >> extended without problem.
> >
> >Sure, coax inputs are the best. But there are still problems. Even
> >expensive coax has higher attenuation at higher frequencies, so the
> >longer the cable, the more fuzziness you get. Also, there are
> >differential delay effects between the R, G and B components. You
> >don't want the pixel components to arrive at different times. So
> >there's a length limitation there as well.
> >
> >But even though coax is better, VGA isn't that bad. 15 m gets you
> >quite a lot of terminals in a web kiosk (or undergrad computer lab).
> >
> >BTW: I agree that X terminals suck. Even worse are SunRays. Ug!
> >
> 
> We have built a 'pseudo-CAVE' for presentations, and have six vgas
> feeding sony projectors with cabling between 15 and 20m, running
> at 1024x768@32. Quality is ok.
> 
> The problem is finding good PCI vga cards, even finding any,
> good or bad. Now they are TNT-M64. I'm also aware that SiS has some,
> but nothing special. But, to use it as terminals, they could be ok.
> 
> And coax is not so good. Even with expensive cable, the bounces of
> the signal made me see double like drunk. Video did not worked right
> until we got _golden_ connectors and soldered with silver. Believe
> me you could even put more mony on the cables that on the box.

Are you sure your monitors had properly matched terminators?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
