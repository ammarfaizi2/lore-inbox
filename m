Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUA3IsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 03:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266322AbUA3IsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 03:48:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31751 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263742AbUA3IsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 03:48:13 -0500
Date: Fri, 30 Jan 2004 08:48:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dan Lenski <lenski@umd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: orinoco_cs IRQ problem with 2.6.0
Message-ID: <20040130084810.B9894@flint.arm.linux.org.uk>
Mail-Followup-To: Dan Lenski <lenski@umd.edu>, linux-kernel@vger.kernel.org
References: <1075423670.1212.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1075423670.1212.12.camel@localhost>; from lenski@umd.edu on Thu, Jan 29, 2004 at 07:50:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 07:50:13PM -0500, Dan Lenski wrote:
> I'm new to the list.  My D-Link cardbus wireless card worked fine under
> 2.4.22 using the orinoco_cs drivers, and the pcmcia-cs-3.2.5 package.
> 
> Under 2.6.0, with the orinoco_cs driver, I get the following errors in
> my syslog:

This problem should be fixed in 2.6.1.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
