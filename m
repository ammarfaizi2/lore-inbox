Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbUKCXzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUKCXzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUKCXx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:53:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:9703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261995AbUKCXsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:48:37 -0500
Date: Wed, 3 Nov 2004 15:46:49 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] KC2190 support for usbnet.
Message-ID: <20041103234649.GA31794@kroah.com>
References: <20041103115142.GZ31945@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103115142.GZ31945@earth.li>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 11:51:42AM +0000, Jonathan McDowell wrote:
> The patch below adds support for the KC2190 usb-to-usb networking
> device; the version I have reports itself as:
> 
> Bus 001 Device 003: ID 050f:0190 KC Technology, Inc.
> 
> I was under the impression that support for this had been added a long
> time ago, but searching through old kernel versions all I could find was
> a comment about the chip, with no support. Patch is against 2.6.9 but is
> pretty minimal.
> 
> I don't have a Windows box around to test interoperability with that
> driver, but the patch appears to make it work perfectly between 2 Linux
> boxes.

Applied, thanks.

greg k-h
