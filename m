Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVC3I4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVC3I4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 03:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVC3I4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 03:56:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19979 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261789AbVC3I4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 03:56:10 -0500
Date: Wed, 30 Mar 2005 09:56:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm3] m32r: m32r_sio driver update (was Re: [PATCH] Re: Bitrotting serial drivers)
Message-ID: <20050330095604.A6239@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050324.191424.233669632.takata.hirokazu@renesas.com> <20050324121746.A4189@flint.arm.linux.org.uk> <20050330.095948.412902706.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050330.095948.412902706.takata.hirokazu@renesas.com>; from takata@linux-m32r.org on Wed, Mar 30, 2005 at 09:59:48AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 09:59:48AM +0900, Hirokazu Takata wrote:
> Here is an additional patch to update m32r_sio driver.
> This patch is against 2.6.12-rc1-mm3.
> 
> m32r_sio driver updates:
> - Move m32r_sio specific description from asm-m32r/serial.h to 
>   driver/serial/m32r_sio.c.
> - Remove __register_m32r_sio, register_m32r_sio and unregister_m32r_sio
>   from driver/serial/m32r_sio.c.
> 
> Thank you.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
