Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVGaXFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVGaXFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVGaXFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:05:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:36539 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262017AbVGaXFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:05:53 -0400
Date: Sun, 31 Jul 2005 16:02:44 -0700
From: Greg KH <greg@kroah.com>
To: david-b@pacbell.net
Cc: iogl64nx@gmail.com, akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: 2.6.13-rc4-mm1
Message-ID: <20050731230244.GA20811@kroah.com>
References: <20050731020552.72623ad4.akpm@osdl.org> <42ECEA30.5060204@gmail.com> <20050731104214.5c0e686c.akpm@osdl.org> <20050731182510.D11F2DB13C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731182510.D11F2DB13C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 11:25:10AM -0700, david-b@pacbell.net wrote:
> I think that "continuing" codepath came from someone at Phoenix, FWIW;
> the problem is that I see the PCI quirks code has evolved even farther
> from the main copy of the init code in the USB tree.  Sigh.

I don't like that either, but can't think of a way to make it easier to
keep them in sync.  Can you?

thanks,

greg k-h
