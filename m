Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269695AbUINUSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269695AbUINUSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269768AbUINUQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:16:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269730AbUINUIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:08:53 -0400
Date: Tue, 14 Sep 2004 15:28:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: dm@sangoma.com, ncorbic@sangoma.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.28-pre3] WANPIPE/SDLA driver gcc-3.4 fixes
Message-ID: <20040914182818.GB30422@logos.cnet>
References: <200409121127.i8CBRraH015212@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409121127.i8CBRraH015212@harpo.it.uu.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 01:27:53PM +0200, Mikael Pettersson wrote:
> This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
> kernel's WANPIPE/SDLA net drivers. The 2.6 version of the code has
> not been fixed for gcc-3.4, so the changes are all new.

What about getting them in v2.6?
