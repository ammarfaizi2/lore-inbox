Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317996AbSGZSoy>; Fri, 26 Jul 2002 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317997AbSGZSoy>; Fri, 26 Jul 2002 14:44:54 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:24332 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317996AbSGZSox>;
	Fri, 26 Jul 2002 14:44:53 -0400
Date: Fri, 26 Jul 2002 11:47:34 -0700
From: Greg KH <greg@kroah.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Sven.Riedel@tu-clausthal.de, linux-kernel@vger.kernel.org
Subject: Re: USB Keyboards with recent 2.4.19-pre/rcXX and 2.5.2X
Message-ID: <20020726184734.GM22091@kroah.com>
References: <20020724140026.GE9765@moog.heim1.tu-clausthal.de> <20020725161221.GA10866@moog.heim1.tu-clausthal.de> <20020725181519.GC16518@kroah.com> <200207260739.39546.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207260739.39546.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 28 Jun 2002 16:05:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 07:39:39AM +1000, Brad Hards wrote:
> On Fri, 26 Jul 2002 04:15, Greg KH wrote:
> > On Thu, Jul 25, 2002 at 06:12:21PM +0200, Sven.Riedel@tu-clausthal.de wrote:
> > > On Wed, Jul 24, 2002 at 10:35:05AM -0700, Greg KH wrote:
> > > > Is CONFIG_USB_HIDINPUT selected in your .config?
> > >
> > > Now it is, and now it works. Thanks for the tip.
> >
> > Ah, and I didn't believe people when I said this wasn't going to be a
> > problem...:
> > 	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101761858728615&w=2
> For your sins, I sentence you to two weeks of user support.

Hm, can I use "previous time served" on linux-usb-users and here as a
credit for this sentence?  :)

greg k-h
