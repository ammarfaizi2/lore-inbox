Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVHRTmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVHRTmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 15:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVHRTmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 15:42:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932408AbVHRTmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 15:42:23 -0400
Date: Thu, 18 Aug 2005 20:42:18 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Mukund JB`." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: How to support partitions in driver?
Message-ID: <20050818204218.A2106@flint.arm.linux.org.uk>
Mail-Followup-To: "Mukund JB`." <mukundjb@esntechnologies.co.in>,
	linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
References: <3AEC1E10243A314391FE9C01CD65429B3849@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B3849@mail.esn.co.in>; from mukundjb@esntechnologies.co.in on Thu, Aug 18, 2005 at 01:17:51PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 01:17:51PM +0530, Mukund JB`. wrote:
> I guess it will involve enough amount of work. If NOT, please provide me
> the documentation if available, HOW-TO use the MMC layer.

I've suggested that you look through the existing three drivers.
There is no how-to written yet, and I don't have time to write one
in the next couple of days before I'm on vacation.

Neither can I teach you how to add partition support to your driver
in these two days.  Again, there's plenty of examples in the kernel,
even in the MMC layer if you really want to re-implement it.

Please try reading some of the already merged code and try to
understand it, as I have already suggested.  Alternatively, please
wait until September.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
