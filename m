Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270424AbTGMWbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 18:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270425AbTGMWbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 18:31:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60433 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270424AbTGMWbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 18:31:34 -0400
Date: Sun, 13 Jul 2003 23:46:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] remove CONFIG_SERIAL_21285_OLD
Message-ID: <20030713234615.H2621@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <20030713224110.GD12104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030713224110.GD12104@fs.tum.de>; from bunk@fs.tum.de on Mon, Jul 14, 2003 at 12:41:11AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 12:41:11AM +0200, Adrian Bunk wrote:
> CONFIG_SERIAL_21285_OLD depends on the non-existent option
> CONFIG_OBSOLETE, IOW it's not selectable, and the help text says "This
> is obsolete and will be removed during later 2.5 development.".
> 
> Is the patch below to remove this option OK?

Absolutely fine by me.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
