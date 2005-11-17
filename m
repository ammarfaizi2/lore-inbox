Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVKQQK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVKQQK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVKQQK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:10:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34826 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932314AbVKQQK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:10:26 -0500
Date: Thu, 17 Nov 2005 16:10:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: linux-kernel@vger.kernel.org,
       ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug after _Convert platform drivers to use_ (again)
Message-ID: <20051117161015.GC26032@flint.arm.linux.org.uk>
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
> I fear it is not a last patch of such kind :(.
> Please recheck places where you are changed
> pdev<->dev.

Applied.  However, what you ask is to review the entire kernel looking
for a one-character error needle in a massive haystack.  That's a job
better suited to compilers than eyes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
