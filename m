Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbUKEOaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbUKEOaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbUKEOaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:30:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27147 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262702AbUKEOaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:30:02 -0500
Date: Fri, 5 Nov 2004 14:29:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: remy.gauguey@mindspeed.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: non_linear memory on ARM
Message-ID: <20041105142953.A22402@flint.arm.linux.org.uk>
Mail-Followup-To: remy.gauguey@mindspeed.com, linux-kernel@vger.kernel.org
References: <OFC878058C.F34D3F6A-ONC1256F43.004C88F3-C1256F43.004DDB20@nice.mindspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFC878058C.F34D3F6A-ONC1256F43.004C88F3-C1256F43.004DDB20@nice.mindspeed.com>; from remy.gauguey@mindspeed.com on Fri, Nov 05, 2004 at 03:10:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 03:10:12PM +0100, remy.gauguey@mindspeed.com wrote:
> I've tried to use the CONFIG_DISCONTIGMEM, but it seems that the large gap
> of 2,5 Gb is a problem.

What problem are you seeing?

PS, Do NOT cross post between linux-kernel and linux-arm-kernel.  Strictly
one or the other please, never both.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
