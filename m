Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267747AbUBTI54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 03:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUBTI54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 03:57:56 -0500
Received: from ztxmail01.ztx.compaq.com ([161.114.1.205]:11784 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267747AbUBTI5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 03:57:53 -0500
Date: Fri, 20 Feb 2004 14:29:47 +0530 (IST)
From: Raj <obelix123@toughguy.net>
X-X-Sender: obelix123@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Gcc problems on linux-2.6.3
In-Reply-To: <Pine.LNX.4.56.0402201411240.1554@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0402201428310.1554@localhost.localdomain>
References: <Pine.LNX.4.56.0402201411240.1554@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Included the subject line now. i apologise.

/Raj

Life is the art of drawing sufficient conclusions from insufficient
premises.


On Fri, 20 Feb 2004, Raj wrote:

> Hi,
> 
> I am facing a weird problem with gcc 3.2.2 on RedHat 9.0 machine running
> vanilla 2.6.3.Glibc 2.3.2.
> 
> gcc fails to compile c programs. More specifically it fails during the
> assembler phase. I boot back 2.6.2 and things work fine. Below are the
> error messages.
> 
> ----start-----
> /tmp/ccfRiElp.o: File truncated
> /tmp/ccNO4FCk.s: Assembler messages:
> /tmp/ccNO4FCk.s:23: FATAL: Can't write /tmp/ccfRiElp.o: File truncated
> ---end------
> The source is a simple program which just has a printf.
> 
> I am attaching the strace output when ran on 2.6.3. If you need
> strace output of 2.6.2. pls let me know.
> 
> /Raj
> 
> Life is the art of drawing sufficient conclusions from insufficient
> premises.
> 
