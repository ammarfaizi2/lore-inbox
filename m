Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVGJMDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVGJMDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 08:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVGJMDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 08:03:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47118 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261797AbVGJMDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 08:03:48 -0400
Date: Sun, 10 Jul 2005 13:03:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: Serial PCI driver in 2.6.x kernel (i.e. 8250_pci HOWTO)
Message-ID: <20050710130343.A3279@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Schulte <matts@commtech-fastcom.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <MFEBKNPNJBEAJEICJEJNOEBECLAA.matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <MFEBKNPNJBEAJEICJEJNOEBECLAA.matts@commtech-fastcom.com>; from matts@commtech-fastcom.com on Tue, Jul 05, 2005 at 04:06:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 04:06:22PM -0500, Matt Schulte wrote:
> In the past (2.4.x days) I have just hacked the serial.c code to do what I
> needed and then recompiled it as something else.

Can we see this code?

> Remember, please copy the serial list at linux-serial@vger.kernel.org

Despite being the maintainer for the serial layer, I'm not on linux-serial.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
