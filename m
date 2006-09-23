Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWIWVOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWIWVOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 17:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWIWVOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 17:14:25 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:30731 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750792AbWIWVOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 17:14:24 -0400
Date: Sat, 23 Sep 2006 22:14:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] at91_serial: Introduction
Message-ID: <20060923211417.GB4363@flint.arm.linux.org.uk>
Mail-Followup-To: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11545303083273-git-send-email-hskinnemoen@atmel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 04:51:45PM +0200, Haavard Skinnemoen wrote:
> Another thing: Andrew, are you the official maintainer of this driver?
> If not, who is?

I've not heard from Andrew, so I'm not sure what to do about this.  I
think these changes need validating by someone with the existing driver's
hardware (iow, AT91RM9200 and/or AT91SAM9261) so we can be sure we don't
break that support.

Andrew?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
