Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265026AbUD2XHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbUD2XHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUD2XHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:07:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10253 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265026AbUD2XHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 19:07:38 -0400
Date: Fri, 30 Apr 2004 00:07:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Ian Campbell <icampbell@arcom.com>, stefan.eletzhofer@eletztrick.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
Message-ID: <20040430000734.N16407@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Ian Campbell <icampbell@arcom.com>, stefan.eletzhofer@eletztrick.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
References: <20040429120250.GD10867@gonzo.local> <1083242482.26762.30.camel@icampbell-debian> <20040429135408.G16407@flint.arm.linux.org.uk> <20040429224007.GA15265@smtp.west.cox.net> <20040429234945.M16407@flint.arm.linux.org.uk> <20040429225238.GB15265@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040429225238.GB15265@smtp.west.cox.net>; from trini@kernel.crashing.org on Thu, Apr 29, 2004 at 03:52:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 03:52:38PM -0700, Tom Rini wrote:
> Either way, I'd like to not have 2 generic rtc drivers if at all
> possible...

So would I...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
