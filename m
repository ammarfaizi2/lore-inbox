Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUBUOxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUBUOxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:53:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7698 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261569AbUBUOxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:53:16 -0500
Date: Sat, 21 Feb 2004 14:53:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mark Hindley <mark@hindley.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.3 fix 8250_pnp resource allocation
Message-ID: <20040221145308.A1937@flint.arm.linux.org.uk>
Mail-Followup-To: Mark Hindley <mark@hindley.uklinux.net>,
	linux-kernel@vger.kernel.org
References: <20040221142804.GA5292@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040221142804.GA5292@titan.home.hindley.uklinux.net>; from mark@hindley.uklinux.net on Sat, Feb 21, 2004 at 02:28:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 02:28:04PM +0000, Mark Hindley wrote:
> Patch below to ensure that 8250_pnp sets necessary flags so that 8250
> driver will reserve ioports.

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
