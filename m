Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWCHSZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWCHSZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWCHSZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:25:22 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:61591
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751536AbWCHSZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:25:21 -0500
Date: Wed, 8 Mar 2006 10:25:06 -0800
From: Greg KH <greg@kroah.com>
To: Lanslott Gish <lanslott.gish@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Message-ID: <20060308182506.GA24077@kroah.com>
References: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com> <200603061205.32660.oliver@neukum.org> <38c09b90603071857g11e333a2l5a00ff3ba9e93b12@mail.gmail.com> <20060308052540.GC29867@kroah.com> <38c09b90603080015p3af7c498i34a49ce9a4a29e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c09b90603080015p3af7c498i34a49ce9a4a29e58@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 04:15:36PM +0800, Lanslott Gish wrote:
> truely sorry for that oversight :)
> 
> here come the one, and i modified the name "touchsetusb" to "usbtouchset"
> 
> thx for ur help.
> 
> 
> 
> Lanslott Gish
> 
> 
> ==========================================================
> 
> diff -u -N linux-2.6.16-rc5/drivers/usb/input/hid-core.c
> linux-2.6.16-rc5.modi/drivers/usb/input/hid-core.c
> --- linux-2.6.16-rc5/drivers/usb/input/hid-core.c    2006-02-27 13:09:
> 35.000000000 +0800
> +++ linux-2.6.16-rc5.modi/drivers/usb/input/hid-core.c    2006-03-02 10:20:
> 36.000000000 +0800

Still linewrapped :(

And what about merging with the existing driver?

thanks,

greg k-h
