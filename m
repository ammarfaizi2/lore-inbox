Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWCYSPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWCYSPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWCYSPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:15:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18445 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932088AbWCYSPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:15:47 -0500
Date: Sat, 25 Mar 2006 18:15:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include/linux/clk.h is betraying its ARM origins
Message-ID: <20060325181539.GA25788@flint.arm.linux.org.uk>
Mail-Followup-To: Todd Poynor <tpoynor@mvista.com>,
	linux-kernel@vger.kernel.org
References: <20060322235116.GA22213@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322235116.GA22213@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 03:51:16PM -0800, Todd Poynor wrote:
> include/linux/clk.h is betraying its ARM origins.

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
