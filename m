Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWAUAhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWAUAhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWAUAhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:37:03 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:48037
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932319AbWAUAgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:36:46 -0500
Date: Fri, 20 Jan 2006 16:36:44 -0800
From: Greg KH <greg@kroah.com>
To: Matt Waddel <Matt.Waddel@freescale.com>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: License oddity in some m68k files
Message-ID: <20060121003644.GA22640@kroah.com>
References: <43D17F4D.2010003@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D17F4D.2010003@freescale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 05:24:45PM -0700, Matt Waddel wrote:
> >> Alan Cox wrote:
> >>
> >>> On Gwe, 2006-01-20 at 07:21 -0500, Ric Wheeler wrote:
> >>>
> >>>> The language in the source files is pretty strong and this looks
> >>>> like
> >>>> Motorola should be asked to rerelease the files with a normal
> >>>> copyright notice in place of the current language...
> >>>>
> >>>
> >>> Its standard boilerplate from the period. Its a perfectly normal and
> >>> clear copyright notice.
> >>>
> >>> Alan
> >>>
> >> Actually, that is the exact language our lawyers still give us to
> >> use today when we have not settled on license terms when we want to
> >> share code in a severely limited fashion.
> >>
> >> I still think it best that they (Freescale) modify their language
> >> to reference the actual license grant in the README.
> >
> >Good luck finding anyone in Freescale that would have any idea about
> >this.
> >
> >- kumar
> >-
> 
> I have been given permission to fix the "UNPUBLISHED PROPRIETARY
> SOURCE CODE OF MOTOROLA ..." section in the source files of fpsp040/
> directory.
> 
> One suggestion, so we don't have to revisit this topic in 16 years
> from now again, shouldn't we just remove the UNPUBLISHED ... comment
> altogether and replace it with Greg Kroah-Hartman's suggested verbiage
> as in the patch below?

Sure, that works for me.  Anyone going to forward this upstream?

Thanks a lot for looking into this,

greg k-h
