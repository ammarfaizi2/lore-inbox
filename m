Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWIYMQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWIYMQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWIYMQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:16:58 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:63242 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751108AbWIYMQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:16:57 -0400
Date: Mon, 25 Sep 2006 13:16:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] at91_serial: Introduction
Message-ID: <20060925121650.GA4119@flint.arm.linux.org.uk>
Mail-Followup-To: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
References: <11545303083273-git-send-email-hskinnemoen@atmel.com> <20060923211417.GB4363@flint.arm.linux.org.uk> <20060925140123.12bf8cd5@cad-250-152.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925140123.12bf8cd5@cad-250-152.norway.atmel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 02:01:23PM +0200, Haavard Skinnemoen wrote:
> I can resend them as individual patches if it helps make it more clear
> that they don't really depend on each other.

If you think that will help.

> I have a AT91RM9200-EK board lying around, so I might be able to test
> the patches on that as soon as I get the necessary cross compilers and
> other tools set up.

If you need toolchains, then they're already available on the net for
easy download, as Lennert recently pointed out:

|  As I regularly test with different gcc versions and encourage others
|  to do the same, I've had a set available for a while at:
|
|        http://www.wantstofly.org/~buytenh/kernel/arm-cross/
|
|  (Generated with crosstool 0.42, see http://kegel.com/crosstool)  Any
|  suggestions for making them easier to find for folks?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
