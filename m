Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWFOEIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWFOEIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 00:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWFOEIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 00:08:21 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:61621 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932431AbWFOEIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 00:08:21 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Miller <mike.miller@hp.com>
Subject: Re: [PATCH 7/7] CCISS: run through Lindent
Date: Wed, 14 Jun 2006 22:08:01 -0600
User-Agent: KMail/1.8.3
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200606141707.27404.bjorn.helgaas@hp.com> <200606141713.46497.bjorn.helgaas@hp.com>
In-Reply-To: <200606141713.46497.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606142208.01631.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 17:13, Bjorn Helgaas wrote:
> cciss is full of inconsistent style ("for (" vs. "for(", lines that
> end with whitespace, lines beginning with a mix of spaces & tabs, etc).
> 
> This patch changes only whitespace.

This patch was too big for the linux-kernel list.   You can get
the whole thing here:

$ wget ftp://ftp.kernel.org/pub/linux/kernel/people/helgaas/cciss-indent
