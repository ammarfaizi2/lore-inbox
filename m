Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVHTQUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVHTQUs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 12:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVHTQUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 12:20:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14608 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932474AbVHTQUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 12:20:48 -0400
Date: Sat, 20 Aug 2005 17:20:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/adfs/adfs.h: "extern inline" doesn't make sense
Message-ID: <20050820172042.B27756@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050819234119.GD3615@stusta.de> <20050819234443.GG3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050819234443.GG3615@stusta.de>; from bunk@stusta.de on Sat, Aug 20, 2005 at 01:44:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 01:44:43AM +0200, Adrian Bunk wrote:
> "extern inline" doesn't make sense.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks Adrian - I've committed it to my tree.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
