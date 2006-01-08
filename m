Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWAHCdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWAHCdX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 21:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWAHCdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 21:33:23 -0500
Received: from waste.org ([64.81.244.121]:7373 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1161150AbWAHCdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 21:33:23 -0500
Date: Sat, 7 Jan 2006 20:26:32 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] misc: Configurable support for PCI serial ports
Message-ID: <20060108022632.GZ3356@waste.org>
References: <15.282480653@selenic.com> <16.282480653@selenic.com> <20060107165028.GI31384@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107165028.GI31384@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 04:50:28PM +0000, Russell King wrote:
> On Fri, Nov 11, 2005 at 02:35:57AM -0600, Matt Mackall wrote:
> > Configurable support for PCI serial devices
> > 
> > This allows disabling support for _non_-legacy PCI serial devices.
> 
> Why is the config for SERIAL_PCI in init/Kconfig rather than
> drivers/serial/Kconfig ?

No good reason, will fix.

-- 
Mathematics is the supreme nostalgia of our time.
