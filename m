Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSEWRsy>; Thu, 23 May 2002 13:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSEWRsx>; Thu, 23 May 2002 13:48:53 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:47623 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316668AbSEWRsw>;
	Thu, 23 May 2002 13:48:52 -0400
Date: Thu, 23 May 2002 10:48:35 -0700
From: Greg KH <greg@kroah.com>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
Message-ID: <20020523174835.GA11766@kroah.com>
In-Reply-To: <20020520223132.GC25541@kroah.com> <m2adqqiwxp.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 25 Apr 2002 16:25:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 07:41:22PM +0200, Peter Osterlund wrote:
> Greg KH <greg@kroah.com> writes:
> 
> >   From now until July 1, I want everyone to test out both the uhci-hcd
> >   and usb-uhci-hcd drivers on just about every piece of hardware they
> >   can find.
> 
> I need this patch to convince the Makefile to build the new drivers.

Already in Linus' tree, and will show up in 2.5.18.

thanks,

greg k-h
