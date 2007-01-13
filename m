Return-Path: <linux-kernel-owner+w=401wt.eu-S1161172AbXAMAsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbXAMAsw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbXAMAsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:48:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:55274 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161162AbXAMAsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:48:51 -0500
Date: Fri, 12 Jan 2007 16:48:17 -0800
From: Greg KH <greg@kroah.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /sys/$DEVPATH/uevent vs uevent attributes
Message-ID: <20070113004817.GA4870@kroah.com>
References: <45A7E23A.6000100@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A7E23A.6000100@tls.msk.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 10:32:10PM +0300, Michael Tokarev wrote:
> 
> (No patch at this time, -- just asking about an.. idea ;)

Let's see what such a patch looks like to see if it would be workable or
not.

And no one forces you to use udev, I have machines with a static /dev
that work just fine :)

thanks,

greg k-h
