Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUEZSfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUEZSfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUEZSfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:35:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:61834 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265773AbUEZSfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:35:06 -0400
Date: Wed, 26 May 2004 11:29:19 -0700
From: Greg KH <greg@kroah.com>
To: Zenaan Harkness <zen@freedbms.net>
Cc: linux-kernel@vger.kernel.org,
       "debian-devel@lists.debian.org" <debian-devel@lists.debian.org>
Subject: Re: [Fwd: Re: drivers DB and id/ info registration]
Message-ID: <20040526182919.GA25978@kroah.com>
References: <1085548092.2909.60.camel@zen8100a.freedbms.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085548092.2909.60.camel@zen8100a.freedbms.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 03:08:13PM +1000, Zenaan Harkness wrote:
> I think we need to somehow make it easy for manufacturers to submit
> information about their hardware - something centralized, kernel- and
> distro- neutral, that can be widely advertised to manufacturers.

What kind of information?  Device ids are pretty useless in and of
themselves.  What we need are device specs in order to produce proper
drivers.  Without that information, just having a device id is
pointless.

thanks,

greg k-h
