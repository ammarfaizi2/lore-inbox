Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWBFBfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWBFBfH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 20:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWBFBfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 20:35:07 -0500
Received: from mail.renesas.com ([202.234.163.13]:48530 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1750739AbWBFBfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 20:35:05 -0500
Date: Mon, 06 Feb 2006 10:34:43 +0900 (JST)
Message-Id: <20060206.103443.608416320.takata.hirokazu@renesas.com>
To: rmk+lkml@arm.linux.org.uk
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060205000136.GF24887@flint.arm.linux.org.uk>
References: <20060202102721.GE5034@flint.arm.linux.org.uk>
	<20060202.231033.1059963967.takata.hirokazu@renesas.com>
	<20060205000136.GF24887@flint.arm.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.18 (Social Property)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Date: Sun, 05 Feb 2006 00:01:36 +0000
> On Thu, Feb 02, 2006 at 11:10:33PM +0900, Hirokazu Takata wrote:
> > On m32r,
> >   compile and boot test: OK
> 
> Is that an Acked-by ?
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> 

Yes.

Acked-by: Hirokazu Takata <takata@linux-m32r.org>

Thanks,
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

