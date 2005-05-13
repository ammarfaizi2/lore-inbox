Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVEMX0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVEMX0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVEMXZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:25:59 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:28102 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262615AbVEMXYP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:24:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c3T66JTxRAHWf5x1hDO56RsYuY1PYR2+etMNsTP+u/WHj8/Agse6HA2r36V0IIWHKX6/qjScCEyGIGO3guqvdQcXX2WOuSHWzzXUPcCZGN7ueFs7+NkZyJfW7mPQMkGobuQT5eHghJfwTRMOV8Ox4IT6lCL/IRfzXwazg1adpI8=
Message-ID: <35fb2e5905051316247eb5d4f6@mail.gmail.com>
Date: Sat, 14 May 2005 00:24:15 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Sync option destroys flash!
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1xbr7eydeg.fsf@ford.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1116001207.5239.38.camel@localhost.localdomain>
	 <1116009619.9371.494.camel@localhost.localdomain>
	 <1116011430.5239.108.camel@localhost.localdomain>
	 <1116021632.20550.11.camel@localhost.localdomain>
	 <yw1xbr7eydeg.fsf@ford.inprovide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/05, Måns Rullgård <mru@inprovide.com> wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > On Gwe, 2005-05-13 at 20:10, Michael H. Warfield wrote:

> >>  But how do you determine which are
> >> "decent" keys?  They don't put stickers on them saying "this one is
> >> decent" and "this one is junk" and I'm an old cynic who has learned that
> >> price is not always a good indicator either.  Maybe the guarantee will
> >> be a clue.  I've just got to shop for it more.
> >
> > Or it may even be cheaper to "burn" a few - buy one of each type from
> > various shops, do 2 million writes to the same sector and take them back
> > the next day if they died [And publish the review data 8))]
> 
> It's probably a good idea to get from different shops, or someone
> might get suspicious when you take them back.

Not really. I doubt the person in the shop will care.

Incidentally, I've discovered that you really don't want to buy flash
devices from camera shops. It would seem that, like I guess might be
the case with certain "audio CD" blanks you buy in stores, they don't
seem to care about selling you a device with one or two known-bad
sectors. You won't notice 512 bytes of lost data in many JPEG images
(not that I am saying it's a good practice to have) but my Zaurus
/did/ notice when I couldn't reflash it from a CF card with a fault
somewhere around 8MB. After quite some time of screwing around with
the filesystem by hand, I was able to ensure that something else was
occupying the sector in question and eventually was able to reflash
(all because it was a Sunday afternoon and we have silly Sunday
trading laws here).

When I took the CF card back to the camera shop, I took the Zaurus and
did a test on potential replacement cards while in the store -
explaining that my PDA had a "CompactFlash tester" installed, or
something like that. It's amazing what you can get away with - akin to
spending an hour in the store when I got my replacement Powerbook
after finding a single bad pixel, testing every unit to find one
without any, just to be happy :-)

Jon.
