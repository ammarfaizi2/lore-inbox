Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270518AbUJTXl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270518AbUJTXl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270509AbUJTXlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:41:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12456 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270506AbUJTXft
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:35:49 -0400
Date: Thu, 21 Oct 2004 00:35:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [CFT] 2.6.9-bk4-bird1 patchset
Message-ID: <20041020233547.GN23987@parcelfarce.linux.theplanet.co.uk>
References: <20041016005230.GF23987@parcelfarce.linux.theplanet.co.uk> <20041018020617.GH23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018020617.GH23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

News:
	* based on 2.6.9-bk4 now
	* a bunch of drivers/net/* stuff got merged, patchset based on more
recent bk-net.

	Currently patch is on
ftp.linux.org.uk/pub/people/viro/patch-2.6.9-bk4-bird1.bz2.  Splitup is
in ftp.linux.org.uk/pub/people/viro/patchset/.
 
 	Added chunks:
ncr		ncr.../sym... iomem annotations
alpha-numa	CONFIG_NUMA is broken on alpha right now
ppc-fix		missing externs in ppc irq.c
netdev-fixes2	compile fixes in typhoon.c and ne2k-pci.c
