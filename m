Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265637AbVBEBog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265637AbVBEBog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbVBEBof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:44:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:43200 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265984AbVBEBob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:44:31 -0500
Date: Fri, 4 Feb 2005 17:44:13 -0800
From: Greg KH <greg@kroah.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>
Subject: Re: 2.6: USB disk unusable level of data corruption
Message-ID: <20050205014413.GB31596@kroah.com>
References: <1107519382.1703.7.camel@localhost.localdomain> <20050204133726.7ba8944f@localhost.localdomain> <1107564013.10471.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107564013.10471.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 07:40:13PM -0500, Parag Warudkar wrote:
> I don't know if it's related, but -
> I have been using Maxtor OneTouch USB Drive,so far without problems, but
> today after upgrading to FC3 2.6.10-760 kernel I just recieved this in
> dmesg

Does 2.6.11-rc3 have this same issue?

thanks,

greg k-h
