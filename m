Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945960AbWBOPBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945960AbWBOPBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945961AbWBOPBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:01:48 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:19974 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1945960AbWBOPBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:01:47 -0500
Date: Wed, 15 Feb 2006 16:01:46 +0100
From: Olivier Galibert <galibert@pobox.com>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060215150146.GB89078@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
	linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <20060213175046.GA20952@kroah.com> <20060213195322.GB89006@dspnet.fr.eu.org> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org> <20060214222428.GA357@kroah.com> <20060214230023.GA66586@dspnet.fr.eu.org> <20060214234546.GA10590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214234546.GA10590@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 03:45:46PM -0800, Greg KH wrote:
> On Wed, Feb 15, 2006 at 12:00:23AM +0100, Olivier Galibert wrote:
> > On Tue, Feb 14, 2006 at 02:24:28PM -0800, Greg KH wrote:
> > > Because if you have to have udev push the names back into the kernel,
> > > why not just ask udev in the first place what they were?
> > 
> > Because there is no reason to think udev of 2008 will be compatible
> > with today's udev given udev's history.  And that's provided udev is
> > still in use at that time.
> 
> Just like gnome and kde of 2008 will not be compatible with the gnome
> and kde of today.

If history is a guide, it will.  KDE is harder because the C++ as
implemented in gcc has changed in the meantime, so things that were
correct-ish two years ago aren't anymore and the libraries aren't
binary-compatible with the older gccs, but in the gtk/gnome case I
have programs I wrote in 1999 that still compile and work as is.  And
in the X case, I have programs from before linux existed that still
compile and work as is.  So I'm not sure what your point is here.


> > > Again, use HAL, not udev for this stuff.  FC3 is also out of date for
> > > lots of things becides udev, so why refer to it?
> > 
> > Because it proves you don't give a shit about backwards compatibility.
> 
> *plonk*

Truth hurts?

  OG.
