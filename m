Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbVICPqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVICPqP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVICPqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:46:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51721 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751469AbVICPqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:46:13 -0400
Date: Sat, 3 Sep 2005 16:46:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] support for mmc chip select in wbsd
Message-ID: <20050903164608.D4416@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <4312EE38.6050600@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4312EE38.6050600@drzeus.cx>; from drzeus-list@drzeus.cx on Mon, Aug 29, 2005 at 01:15:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 01:15:04PM +0200, Pierre Ossman wrote:
> Use the chip select ios in the wbsd driver.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
