Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUJPPKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUJPPKm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUJPPKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:10:42 -0400
Received: from smtp17.wxs.nl ([195.121.6.13]:29929 "EHLO smtp17.wxs.nl")
	by vger.kernel.org with ESMTP id S268752AbUJPPKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:10:40 -0400
Date: Sat, 16 Oct 2004 17:09:22 +0200
From: Erwin Schoenmakers <esc-solutions@planet.nl>
Subject: PROBLEM: while building kernel 2.6.8.1. for Alpha (Miata)
To: linux-kernel@vger.kernel.org
Reply-to: esc-solutions@planet.nl
Message-id: <417139A2.5090705@planet.nl>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.0.0) Gecko/20020622
 Debian/1.0.0-0.woody.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel Developers,

PROBLEM: while building kernel 2.6.8.1. for Alpha (Miata)

I first have configured the linux kernel using menuconfig option.
When I try to build linux kernel 2.6.8.1. on a DEC Alpha (Miata) on
Debian Linux 3.0r2 the following error occurs:

CC        arch/alpha/kernel/traps.o
arch/alpha/kernel/traps.c: In function `opDEC_check':
arch/alpha/kernel/traps.c:55: parse error before `['
make[1]: *** [arch/alpha/kernel/traps.o] Error 1
make: *** [arch/alpha/kernel] Error 2

What could be wrong?

Do I need to install another version of the gnu compiler/assembler?
I have installed:
   gcc version 2.95.4
   as version 2.12.90.0.1 using BFD version 2.12.90.0.1

Best Regards,

Erwin Schoenmakers









