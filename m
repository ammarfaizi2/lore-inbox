Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVKLWEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVKLWEo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVKLWEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:04:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48138 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964828AbVKLWEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:04:43 -0500
Date: Sat, 12 Nov 2005 22:04:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 kernel 2.6.15-rc1]  Fix copy-paste bug in mpc52xx_uart.c (pdev<->dev)
Message-ID: <20051112220433.GK28987@flint.arm.linux.org.uk>
Mail-Followup-To: Andrey Volkov <avolkov@varma-el.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <4375E765.4000207@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4375E765.4000207@varma-el.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 04:00:21PM +0300, Andrey Volkov wrote:
> Fix copy-paste bug in mpc52xx_uart.c (pdev<->dev)

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
