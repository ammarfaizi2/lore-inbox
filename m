Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUIWNls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUIWNls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUIWNls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:41:48 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:10504 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268464AbUIWNky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:40:54 -0400
Message-ID: <35fb2e59040923064034361b4a@mail.gmail.com>
Date: Thu, 23 Sep 2004 14:40:49 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [PATCH] xsa_use_interrupts flag [WAS: xilinx_sysace]
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20040923045114.GF6889@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <35fb2e5904090607241087442d@mail.gmail.com>
	 <35fb2e59040919131864c26952@mail.gmail.com>
	 <35fb2e59040922181249d18af6@mail.gmail.com>
	 <20040923045114.GF6889@thundrix.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 06:51:14 +0200, Tonnerre <tonnerre@thundrix.ch> wrote:

> (No XSA_IRQ here!)

Cheers. I also left in a printk that shouldn't be there - just
adopting the early and often philosophy since this has been bothering
me for a while.

Jon.
