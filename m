Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTIJOC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTIJOCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:02:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55304 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263620AbTIJOCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:02:13 -0400
Date: Wed, 10 Sep 2003 15:01:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910150156.A30046@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DBC1F.8DF1F07A@eyal.emu.id.au> <20030910110225.GC27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910110225.GC27368@fs.tum.de>; from bunk@fs.tum.de on Wed, Sep 10, 2003 at 01:02:25PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 01:02:25PM +0200, Adrian Bunk wrote:
> The patch below should fix it.

I'm confused why you're copying me and not Vojtech.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
