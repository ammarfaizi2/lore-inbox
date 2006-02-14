Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422867AbWBNXpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422867AbWBNXpt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWBNXpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:45:49 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:36519
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1422867AbWBNXps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:45:48 -0500
Date: Tue, 14 Feb 2006 15:45:46 -0800
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060214234546.GA10590@kroah.com>
References: <43D7C1DF.1070606@gmx.de> <20060213175046.GA20952@kroah.com> <20060213195322.GB89006@dspnet.fr.eu.org> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org> <20060214222428.GA357@kroah.com> <20060214230023.GA66586@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214230023.GA66586@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 12:00:23AM +0100, Olivier Galibert wrote:
> On Tue, Feb 14, 2006 at 02:24:28PM -0800, Greg KH wrote:
> > Because if you have to have udev push the names back into the kernel,
> > why not just ask udev in the first place what they were?
> 
> Because there is no reason to think udev of 2008 will be compatible
> with today's udev given udev's history.  And that's provided udev is
> still in use at that time.

Just like gnome and kde of 2008 will not be compatible with the gnome
and kde of today.

> > Again, use HAL, not udev for this stuff.  FC3 is also out of date for
> > lots of things becides udev, so why refer to it?
> 
> Because it proves you don't give a shit about backwards compatibility.

*plonk*
