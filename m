Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275347AbSITXbh>; Fri, 20 Sep 2002 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275320AbSITXbg>; Fri, 20 Sep 2002 19:31:36 -0400
Received: from quattro.sventech.com ([205.252.248.110]:20682 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S275289AbSITXbf>; Fri, 20 Sep 2002 19:31:35 -0400
Date: Fri, 20 Sep 2002 19:36:42 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Message-ID: <20020920193642.I1627@sventech.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <20020919230643.GD18000@kroah.com> <3D8B884A.7030205@pacbell.net> <200209210922.41887.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209210922.41887.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Sat, Sep 21, 2002 at 09:22:41AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002, Brad Hards <bhards@bigpond.net.au> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Sat, 21 Sep 2002 06:42, David Brownell wrote:
> > >>I wasn't joking about putting back the /proc/bus/usb/drivers file. This
> > >> is really going to hurt us in 2.6.
> >
> > Considering that the main use of that file that I know about was
> > implicit (usbfs is available if its files are present, another
> > assumption broken in 2.5), I'm not sure I feel any pain... :-)
> 
> OK. Everytime someone goes "I've got usbfs loaded, and here is 
> /proc/bus/usb/devices, but can't send you /proc/bus/usb/drivers", I'll assume 
> that you two will answer the question.
> 
> Helping people is hard. Please don't make it harder. :-(

Personally, I've never used /proc/bus/usb/drivers. I've always just
looked at lsmod.

Why should this be any different?

JE

