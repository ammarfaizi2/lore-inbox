Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269304AbUIRLVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269304AbUIRLVh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 07:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269333AbUIRLVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 07:21:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58896 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269304AbUIRLVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 07:21:34 -0400
Date: Sat, 18 Sep 2004 12:21:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MMC compatibility fix - OCR mask
Message-ID: <20040918122130.A17085@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <414C0730.3020503@drzeus.cx> <20040918114310.A13733@flint.arm.linux.org.uk> <414C16AD.9020303@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <414C16AD.9020303@drzeus.cx>; from drzeus-list@drzeus.cx on Sat, Sep 18, 2004 at 01:06:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 01:06:21PM +0200, Pierre Ossman wrote:
> The problem still remains though. Do you know what the wide range 
> controller you have send when used with the manufacturer's driver?

There isn't a manufacturers driver for it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
