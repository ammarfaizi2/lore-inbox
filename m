Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbULNW6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbULNW6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbULNW5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:57:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28167 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261737AbULNW43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:56:29 -0500
Date: Tue, 14 Dec 2004 22:56:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/6] mv643xx_eth: Remove use of MV_SET_REG_BITS macro
Message-ID: <20041214225626.A970@flint.arm.linux.org.uk>
Mail-Followup-To: Dale Farnsworth <dale@farnsworth.org>,
	linux-kernel@vger.kernel.org
References: <20041213220949.GA19609@xyzzy> <20041214225150.GA21869@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041214225150.GA21869@xyzzy>; from dale@farnsworth.org on Tue, Dec 14, 2004 at 03:51:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 03:51:50PM -0700, Dale Farnsworth wrote:
> Oops, I missed this in my first set of patches for the mv643xx_eth driver.
> 
> This patch removes the need for the MV_SET_REG_BITS macro in the mv643xx_eth
> driver.
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

I don't have any interest in this ethernet driver - could you stop
copying me please?

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
