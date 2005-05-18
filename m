Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVERSZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVERSZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVERSZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:25:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:37076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262267AbVERSXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:23:09 -0400
Date: Wed, 18 May 2005 11:28:23 -0700
From: Greg KH <greg@kroah.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       MCU.Tools@silabs.com
Subject: Re: Linux support for SiLabs CP210x devices
Message-ID: <20050518182821.GA18855@kroah.com>
References: <20041118173908.GA10667@kroah.com> <20050518155815.GA16544@kroah.com> <428B82A5.6080705@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B82A5.6080705@stesmi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 08:00:05PM +0200, Stefan Smietanowski wrote:
> Is this for real? What exactly do they think they're trying to pull
> here?

Yes this is for real, and I have no idea what they are trying to do.

> I've seen borderline violations but this .. this .. this ..
> 
> If the .h file was bad, the .c's are worse.

Yes it is.  And because of this I know of at least one company that has
switched their hardware design away from using this chip already.
Hopefully everyone else will do the same (with the prolifieration of
cheap, usb to serial chips, that work well with Linux, there is no
reason anyone should use this device.)

thanks,

greg k-h
