Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWJPQl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWJPQl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWJPQlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:41:25 -0400
Received: from [195.171.73.133] ([195.171.73.133]:38044 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S1422640AbWJPQlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:41:25 -0400
Date: Mon, 16 Oct 2006 16:41:24 +0000
From: andrew@walrond.org
To: linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
Message-ID: <20061016164124.GC9350@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20061016141127.GB9350@pelagius.h-e-r-e-s-y.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016141127.GB9350@pelagius.h-e-r-e-s-y.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  [0000000000525990] prom_putchar+0x2c/0x34

I wonder; could this be a timeout during boot because the prom console
is hardware limited to 9600baud and its buffer is full ??

Andrew
