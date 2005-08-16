Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVHPWGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVHPWGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVHPWGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:06:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:50828 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751102AbVHPWGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:06:01 -0400
Date: Tue, 16 Aug 2005 15:05:44 -0700
From: Greg KH <greg@kroah.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev-067 and 2.6.12?
Message-ID: <20050816220544.GA28377@kroah.com>
References: <200508162302.00900.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508162302.00900.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 11:02:00PM +0100, Alistair John Strachan wrote:
> Hi,
> 
> I just tried upgrading udev 053 to 067 on a 2.6.12 system and although the 
> system booted, firmware_class failed to upload the firmware for my wireless 
> card, prism54 was no longer auto loaded, etc. Even manually loading the 
> driver didn't help.
> 
> Any reason why 067 wouldn't work with 2.6.12? Do you have to do something 
> special with hotplug prior to upgrading?

What distro are you using?  What rules file are you using?

067 should work just fine for you, it is for a lot of Gentoo and SuSE
users right now, on 2.6.12.

thanks,

greg k-h
