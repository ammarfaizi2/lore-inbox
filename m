Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSDMTtx>; Sat, 13 Apr 2002 15:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSDMTtw>; Sat, 13 Apr 2002 15:49:52 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:27531 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S310258AbSDMTtw>; Sat, 13 Apr 2002 15:49:52 -0400
Date: Sat, 13 Apr 2002 13:49:43 -0600
Message-Id: <200204131949.g3DJnhD07302@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
In-Reply-To: <3CB889C7.2080907@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Richard Gooch wrote:
> > 
> > Actually, there is some impedance matching. I've seen monitors with
> > hi/lo impedance switches. And I've used 15 m long high-quality VGA
> > cables. The result has been pretty good.
> > 
> 
> The best I've seen is to use Sun D-sub coax or plain coax inputs on
> the monitors that have them.  Those are impedance matched and can be
> extended without problem.

Sure, coax inputs are the best. But there are still problems. Even
expensive coax has higher attenuation at higher frequencies, so the
longer the cable, the more fuzziness you get. Also, there are
differential delay effects between the R, G and B components. You
don't want the pixel components to arrive at different times. So
there's a length limitation there as well.

But even though coax is better, VGA isn't that bad. 15 m gets you
quite a lot of terminals in a web kiosk (or undergrad computer lab).

BTW: I agree that X terminals suck. Even worse are SunRays. Ug!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
