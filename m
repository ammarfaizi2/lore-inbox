Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVLLAxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVLLAxc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVLLAxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:53:32 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:18827 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750969AbVLLAxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:53:31 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm2
Date: Mon, 12 Dec 2005 11:53:18 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <3shpp197r05k8e9togafkg4kelm646quc5@4ax.com>
References: <20051211041308.7bb19454.akpm@osdl.org>
In-Reply-To: <20051211041308.7bb19454.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Dec 2005 04:13:08 -0800, Andrew Morton <akpm@osdl.org> wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/

Locked up on boot just after 

  "USB 2.0 initialised, EHCI 1.00, driver 10 Dec 2004", 

where I'd expect to see the first "USB hub found" message.

box info: http://bugsplatter.mine.nu/test/boxen/sempro/

Sempron SktA on VIA chipset.

Grant.
