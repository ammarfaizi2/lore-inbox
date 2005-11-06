Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVKFJHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVKFJHn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 04:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVKFJHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 04:07:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932347AbVKFJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 04:07:42 -0500
Date: Sun, 6 Nov 2005 09:07:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: pantelis@embeddedalley.com
Cc: linux-kernel@vger.kernel.org, cw@f00f.org,
       Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
Subject: Re: [PATCH] Au1x00 8250 uart support (Updated - take #4).
Message-ID: <20051106090730.GE25134@flint.arm.linux.org.uk>
Mail-Followup-To: pantelis@embeddedalley.com, linux-kernel@vger.kernel.org,
	cw@f00f.org, Pete Popov <ppopov@embeddedalley.com>,
	Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
References: <200509192340.10450.pantelis@embeddedalley.com> <200509222211.22674.pantelis@embeddedalley.com> <20051106084424.GC25134@flint.arm.linux.org.uk> <200511061102.22033.pantelis@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511061102.22033.pantelis@embeddedalley.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 11:02:21AM +0200, Pantelis Antoniou wrote:
> On Sunday 06 November 2005 10:44, Russell King wrote:
> > Do you have a description and sign-off for this patch?
> 
> ---
> 
> Support Au1x00 8250 UARTs using the generic 8250 driver.
> The offsets of the registers are in a different place, and
> some parts cannot handle a full set of modem control signals.
> 
> ---
> 
> Signed-off-by: Pantelis Antoniou <pantelis@embeddedalley.ocm>

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
