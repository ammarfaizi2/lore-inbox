Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWCHFZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWCHFZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 00:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWCHFZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 00:25:51 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:30634
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750815AbWCHFZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 00:25:50 -0500
Date: Tue, 7 Mar 2006 21:25:40 -0800
From: Greg KH <greg@kroah.com>
To: Lanslott Gish <lanslott.gish@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [linux-usb-devel] [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Message-ID: <20060308052540.GC29867@kroah.com>
References: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com> <200603061205.32660.oliver@neukum.org> <38c09b90603071857g11e333a2l5a00ff3ba9e93b12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c09b90603071857g11e333a2l5a00ff3ba9e93b12@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 10:57:28AM +0800, Lanslott Gish wrote:
> Hi all,
> 
> thx a lot ( Oliver :) )
> i fixed some:
> 
> *some macros to func when transfer raw data
> * the way *_ATOMIC" to *_KERNEL
> 
> as usual, for kernel 2.6.16-rc5.
> 
> best rgds,
> 
> 
> ========================================================
> 
> diff -u -N linux-2.6.16-rc5/drivers/usb/input/hid-core.c
> linux-2.6.16-rc5.modi/drivers/usb/input/hid-core.c
> --- linux-2.6.16-rc5/drivers/usb/input/hid-core.c	2006-02-27
> 13:09:35.000000000 +0800
> +++ linux-2.6.16-rc5.modi/drivers/usb/input/hid-core.c	2006-03-02
> 10:20:36.000000000 +0800

Ick, your email client linewrapped the patch.  Care to try again?

thanks,

greg k-h
