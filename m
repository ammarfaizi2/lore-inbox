Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVJABPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVJABPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 21:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVJABPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 21:15:23 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:21149 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S1750709AbVJABPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 21:15:22 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=bvaurSXxC/GZ/ZpV4folSe5PIdufQvNA9Lsw9TaeHRjax8DlT2ZOiOL0IwiyBjF5F
	RKjbbi0RSqUIFVH47PFMw==
Date: Fri, 30 Sep 2005 18:15:08 -0700
From: David Brownell <david-b@pacbell.net>
To: greg@kroah.com, daniel.ritz@gmx.ch
Subject: Re: [PATCH] usb/core/hcd-pci.c: don't free_irq() on suspend
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200509302101.j8UL1Htj026067@hera.kernel.org>
 <20050930233833.GA19471@kroah.com>
In-Reply-To: <20050930233833.GA19471@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051001011508.7B01BEA4D4@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David, this conflicts with your usb/usb-pm-06.patch in my quilt tree.
> I'll try to resolve the merge with my best guess, but you should check
> that I got it right...

The patch is OK with me, I was going to ack it just in case it
grew little penguin fins ... I see it already has, and swam all
the way into 2.6.14-rc3, so little point ... ;)

Yes, I'll double check your merge.

- Dave

