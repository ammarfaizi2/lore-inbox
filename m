Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWCTKY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWCTKY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWCTKY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:24:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49931 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750979AbWCTKY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:24:56 -0500
Date: Mon, 20 Mar 2006 10:24:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] Blackfin serial driver for kernel 2.6.16
Message-ID: <20060320102449.GA6787@flint.arm.linux.org.uk>
Mail-Followup-To: Luke Yang <luke.adi@gmail.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <489ecd0c0603200207i33958c66kce8f54704302e79e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ecd0c0603200207i33958c66kce8f54704302e79e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 06:07:44PM +0800, Luke Yang wrote:
> Index: git/linux-2.6/drivers/serial/bfin_serial_5xx.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/drivers/serial/bfin_serial_5xx.c

Please convert this driver to use the serial_core infrastructure.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
