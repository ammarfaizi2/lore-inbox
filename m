Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUDJUTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUDJUTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:19:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50702 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262100AbUDJUTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:19:24 -0400
Date: Sat, 10 Apr 2004 21:19:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Force build error on undefined symbols
Message-ID: <20040410211921.F4221@flint.arm.linux.org.uk>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040410131028.A4221@flint.arm.linux.org.uk> <40784BF3.7080706@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40784BF3.7080706@quark.didntduck.org>; from bgerst@didntduck.org on Sat, Apr 10, 2004 at 03:33:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 03:33:07PM -0400, Brian Gerst wrote:
> How about adding --no-undefined to LDFLAGS_vmlinux instead?

Excellent. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
