Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTFXJTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 05:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTFXJTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 05:19:37 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:15756 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S261757AbTFXJTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 05:19:36 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm1
References: <20030623232908.036a1bd2.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 24 Jun 2003 11:33:27 +0200
In-Reply-To: <20030623232908.036a1bd2.akpm@digeo.com>
Message-ID: <87r85jn7ko.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm1/
> 
> 
> . PCI and PCMCIA updates
>
> [SNIP]
> 

ti113x: Routing card interrupts to PCI
Yenta IRQ list 0000, PCI irq11
Socket status: 30000006
cs: warning: no high memory space available!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!

This is my result from modprobing yenta_socket and inserting my
wlan-card (NetGear MA311).

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
