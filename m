Return-Path: <linux-kernel-owner+w=401wt.eu-S1752475AbXABI6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbXABI6c (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 03:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbXABI6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 03:58:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:43134 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbXABI6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 03:58:31 -0500
Date: Tue, 2 Jan 2007 00:32:58 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Barr <andrew.james.barr@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cut power to a USB port?
Message-ID: <20070102083258.GA24516@kroah.com>
References: <1167684985.28023.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167684985.28023.4.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 03:56:25PM -0500, Andrew Barr wrote:
> I have a simple question perhaps someone can help me with here...
> 
> I have one of those simple LED keyboard lamps that get their power from
> the USB port. Is there some way in Linux, using files under /sys I would
> imagine, to cut power to the USB port into which this lamp is plugged? I
> know I would have to manually figure out what port it's plugged into, as
> it is not a "real" USB device...e.g. it just draws power. I would like
> to be able to programmatically switch the lamp on and off.

Search the archives of the linux-usb-devel mailing list for a program
that might do this for you (depending on your hardware.)

good luck,

greg k-h
