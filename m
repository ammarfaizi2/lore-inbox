Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTIFOv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 10:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbTIFOv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 10:51:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41742 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261306AbTIFOv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 10:51:28 -0400
Date: Sat, 6 Sep 2003 15:51:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] move MODULE_ALIAS_LDISC definition to include/linux/termio.h
Message-ID: <20030906155124.B29417@flint.arm.linux.org.uk>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
References: <200309061624.15647@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309061624.15647@smurf.noris.de>; from smurf@smurf.noris.de on Sat, Sep 06, 2003 at 04:24:11PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 04:24:11PM +0200, Matthias Urlichs wrote:
> Please don't add non-machine-specific macros to machine-specific
> include files.

A more complete fix has already gone in for this.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
