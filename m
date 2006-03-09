Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbWCIAoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbWCIAoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbWCIAoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:44:06 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:55252
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932656AbWCIAoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:44:05 -0500
Date: Wed, 8 Mar 2006 16:43:49 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Lanslott Gish <lanslott.gish@gmail.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: [linux-usb-devel] Re: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Message-ID: <20060309004349.GB1376@kroah.com>
References: <200603082346.37479.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603082346.37479.daniel.ritz@gmx.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:46:36PM +0100, Daniel Ritz wrote:
> > And what about merging with the existing driver?
> 
> something like this? it's compile tested only. not even tested
> on an egalax screen since i don't have it around...
> if this is ok, we could also merge itmtouch and mtouchusb into a
> single driver.

Looks ok to me.  Would be nice to get a verification from someone who
has the device :)

thanks,

greg k-h
