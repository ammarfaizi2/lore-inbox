Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUHPNXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUHPNXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267609AbUHPNXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:23:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30737 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265477AbUHPNXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:23:37 -0400
Date: Mon, 16 Aug 2004 14:23:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Thomas Winkler <tom@qwws.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ARM: PCI Bridge Problems
Message-ID: <20040816142332.A12367@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Winkler <tom@qwws.net>,
	linux-kernel@vger.kernel.org
References: <20040816125903.GN10616@qwwsII.qwws.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040816125903.GN10616@qwwsII.qwws.net>; from tom@qwws.net on Mon, Aug 16, 2004 at 02:59:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 02:59:03PM +0200, Thomas Winkler wrote:
> If there is anybody out there who can help me getting this problem
> solved I'd really be thankful!

Just a thought, but you could try posting this to the ARM kernel list
linux-arm-kernel which is located on lists.arm.linux.org.uk

I suspect there may be something wrong with the IXP code which
decides whether the access is to the host bridge.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
