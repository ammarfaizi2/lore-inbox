Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUFZXah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUFZXah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUFZXaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:30:30 -0400
Received: from ozlabs.org ([203.10.76.45]:55218 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266524AbUFZXa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:30:26 -0400
Subject: Re: 2.6.7-bk: asm/setup.h and linux/init.h
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040626174904.B30532@flint.arm.linux.org.uk>
References: <20040626153511.A30532@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0406260903190.14449@ppc970.osdl.org>
	 <20040626174904.B30532@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1088292610.3729.0.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 27 Jun 2004 09:30:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-27 at 02:49, Russell King wrote:
> Ok, grepping around for sizeof.*saved_command_line and COMMAND_LINE_SIZE
> resulted in this patch:

Looks fine to me.  Sorry for the breakage.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

