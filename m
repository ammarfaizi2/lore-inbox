Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVAUAG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVAUAG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVAUAG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:06:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:65421 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261253AbVAUAFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:05:03 -0500
Subject: Re: Radeon framebuffer weirdness in -mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       ajoshi@shell.unixbox.com,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20050120234844.GF12076@waste.org>
References: <20050120232122.GF3867@waste.org>
	 <20050120153921.11d7c4fa.akpm@osdl.org>  <20050120234844.GF12076@waste.org>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 11:03:57 +1100
Message-Id: <1106265837.18397.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 15:48 -0800, Matt Mackall wrote:
> On Thu, Jan 20, 2005 at 03:39:21PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > > I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
> > > horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.
> > 
> > Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> 
> FB_RADEON.
> 
> > (cc Ben, who is the likely cuprit ;)
> 
> Btw, ajoshi's address from MAINTAINERS is bouncing.

The file should be updated, I am the radeonfb maintainer now.

> > Which -mm2, btw?  2.6.10-mm2 or 2.6.11-rc1-mm2?
> 
> 2.6.11-rc1-mm2
> 
> > Did you try the corresponding -mm1?
> 
> Nothing between that and .10 yet. Building -mm1 now.

Thanks.

Ben.


