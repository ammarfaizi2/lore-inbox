Return-Path: <linux-kernel-owner+w=401wt.eu-S932863AbXASUAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863AbXASUAd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 15:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbXASUAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 15:00:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60143 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932863AbXASUAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 15:00:32 -0500
Date: Fri, 19 Jan 2007 11:59:46 -0800
From: Greg KH <greg@kroah.com>
To: Marco Ferra <mferra@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Odd USB problem on THOMSON PDP95FM
Message-ID: <20070119195946.GA8218@kroah.com>
References: <bc5b4c660701191055y584edfc7j195933a94c5f1eda@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5b4c660701191055y584edfc7j195933a94c5f1eda@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 06:55:10PM +0000, Marco Ferra wrote:
> Hi kernel developers
> 
> I don't know if this is the proper list but I have a very odd problem
> and it's driving me nuts for the past two days.

I suggest posting this to the linux-usb-devel mailing list, and
including your kernel version, and enable CONFIG_USB_STORAGE_DEBUG to
see the debugging error messages from the usb-storage driver to help us
out.

thanks,

greg k-h
