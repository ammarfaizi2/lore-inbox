Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVATXtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVATXtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVATXtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:49:12 -0500
Received: from waste.org ([216.27.176.166]:31443 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262219AbVATXsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:48:52 -0500
Date: Thu, 20 Jan 2005 15:48:44 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com,
       linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Radeon framebuffer weirdness in -mm2
Message-ID: <20050120234844.GF12076@waste.org>
References: <20050120232122.GF3867@waste.org> <20050120153921.11d7c4fa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120153921.11d7c4fa.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 03:39:21PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
> > horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.
> 
> Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?

FB_RADEON.

> (cc Ben, who is the likely cuprit ;)

Btw, ajoshi's address from MAINTAINERS is bouncing.
 
> Which -mm2, btw?  2.6.10-mm2 or 2.6.11-rc1-mm2?

2.6.11-rc1-mm2

> Did you try the corresponding -mm1?

Nothing between that and .10 yet. Building -mm1 now.

-- 
Mathematics is the supreme nostalgia of our time.
