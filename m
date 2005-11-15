Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVKOTHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVKOTHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVKOTHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:07:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965000AbVKOTHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:07:02 -0500
Date: Tue, 15 Nov 2005 19:06:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: linux-kernel@vger.kernel.org,
       ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug after _Convert platform drivers to use_ (again)
Message-ID: <20051115190655.GA10892@flint.arm.linux.org.uk>
Mail-Followup-To: Andrey Volkov <avolkov@varma-el.com>,
	linux-kernel@vger.kernel.org,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <437A2EE8.4050404@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437A2EE8.4050404@varma-el.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 09:54:32PM +0300, Andrey Volkov wrote:
> Hello Russell,
> 
> I fear it is not a last patch of such kind :(.
> Please recheck places where you are changed
> pdev<->dev.

Either that will have to wait a number of days or someone else will
have to do that.  I'm sorry but I'm rather unwell and in no fit state
to do anything major with kernels atm.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
