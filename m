Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVJaPP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVJaPP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVJaPPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:15:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41119 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932123AbVJaPPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:15:25 -0500
Subject: Re: [PATCH] pci_ids: remove non-referenced symbols from pci_ids.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grant Coady <gcoady@gmail.com>
Cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <436591A5.20609@gmail.com>
References: <200510290000.j9T00Bqd001135@hera.kernel.org>
	 <20051031024217.GA25709@redhat.com>  <436591A5.20609@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Oct 2005 15:45:02 +0000
Message-Id: <1130773502.9145.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-31 at 14:38 +1100, Grant Coady wrote:
> > This patch is removing some PCI idents from drivers that are currently
> > marked BROKEN on some/all architectures.  It seems counterproductive
> > to create even more work to get those drivers fixed.
> 
> Nobody cares, the drivers are dying of bit-rot :)

If you look at the -mm tree you will see various drivers are getting
fixed eventually.

