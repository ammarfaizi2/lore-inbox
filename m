Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTERFe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 01:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTERFe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 01:34:28 -0400
Received: from rth.ninka.net ([216.101.162.244]:59009 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261985AbTERFe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 01:34:27 -0400
Subject: Re: [patch] support 64 bit pci_alloc_consistent
From: "David S. Miller" <davem@redhat.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, James.Bottomley@steeleye.com,
       Grant Grundler <grundler@dsl2.external.hp.com>,
       Colin Ngam <cngam@sgi.com>, Jeremy Higdon <jeremy@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org, wildos@sgi.com
In-Reply-To: <16071.1892.811622.257847@trained-monkey.org>
References: <16071.1892.811622.257847@trained-monkey.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053236773.9215.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 May 2003 22:46:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-17 at 21:09, Jes Sorensen wrote:
> This is patch which provides support for 64 bit address allocations from
> pci_alloc_consistent(), based on the address mask set through
> pci_set_consistent_dma_mask().

I fully support these changes.

