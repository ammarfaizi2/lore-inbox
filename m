Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946152AbWBEABo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946152AbWBEABo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 19:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWBEABo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 19:01:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4107 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030216AbWBEABn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 19:01:43 -0500
Date: Sun, 5 Feb 2006 00:01:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       linuxppc-dev@ozlabs.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060205000136.GF24887@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linuxppc-dev@ozlabs.org, pfg@sgi.com
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk> <20060202102721.GE5034@flint.arm.linux.org.uk> <20060202.231033.1059963967.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202.231033.1059963967.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:10:33PM +0900, Hirokazu Takata wrote:
> On m32r,
>   compile and boot test: OK

Is that an Acked-by ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
