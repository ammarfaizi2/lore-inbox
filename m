Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUFWMZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUFWMZC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUFWMZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:25:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64526 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261947AbUFWMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:24:59 -0400
Date: Wed, 23 Jun 2004 13:24:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 2905] New: Aironet 340 PCMCIA card not working since 2.6.7
Message-ID: <20040623132456.A27549@flint.arm.linux.org.uk>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
References: <200406171753.i5HHrx38015816@fire-2.osdl.org> <Pine.LNX.4.60.0406172152310.5847@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.60.0406172152310.5847@poirot.grange>; from g.liakhovetski@gmx.de on Thu, Jun 17, 2004 at 09:58:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 09:58:32PM +0200, Guennadi Liakhovetski wrote:
> Don't think it will help for this specific problem, but this patch fixes 
> alignment problem (especially seen on ARM, Russell:-)). Sending as a text 
> attachment, as my setup is known to mangle tabs...
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Can you forward this to Jeff Garzik please?

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
