Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422994AbWAMV5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422994AbWAMV5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWAMV5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:57:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42508 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422994AbWAMV5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:57:47 -0500
Date: Fri, 13 Jan 2006 21:57:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: Re: [2.6 patch] drivers/serial/Kconfig: fix SERIAL_M32R_PLDSIO dependencies
Message-ID: <20060113215740.GC31824@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean-Luc Leger <reiga@dspnet.fr.eu.org>
References: <20060110215801.GF3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110215801.GF3911@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 10:58:01PM +0100, Adrian Bunk wrote:
> This patch fixes a typo in the dependencies reported by
> Jean-Luc Leger <reiga@dspnet.fr.eu.org>.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
