Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266471AbUA2Wtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUA2Wta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:49:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:51614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266471AbUA2Wt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:49:29 -0500
Date: Thu, 29 Jan 2004 13:54:51 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040129215451.GA9610@kroah.com>
References: <20040126215036.GA6906@kroah.com> <1075351964.7680.12.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075351964.7680.12.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 06:52:44AM +0200, Martin Schlemmer wrote:
> On Mon, 2004-01-26 at 23:50, Greg KH wrote:
> > I've released the 015 version of udev.  It can be found at:
> >  	kernel.org/pub/linux/utils/kernel/hotplug/udev-015.tar.gz
> > 
> 
> '%D' is still being used in some of the examples ...

Ah, thanks.  I've fixed that up now.

greg k-h
