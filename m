Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUCHWul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUCHWul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:50:41 -0500
Received: from palrel12.hp.com ([156.153.255.237]:20942 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261396AbUCHWue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:50:34 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.63670.103003.460158@napali.hpl.hp.com>
Date: Mon, 8 Mar 2004 14:50:30 -0800
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, benjamin.liu@intel.com,
       iod00d@hp.com, kaneshige.kenji@jp.fujitsu.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
In-Reply-To: <200403081541.35189.bjorn.helgaas@hp.com>
References: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com>
	<200403081505.21644.bjorn.helgaas@hp.com>
	<16460.61267.364413.100233@napali.hpl.hp.com>
	<200403081541.35189.bjorn.helgaas@hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 8 Mar 2004 15:41:35 -0700, Bjorn Helgaas <bjorn.helgaas@hp.com> said:

  Bjorn> I've tested it on my i2000, and it seems to work fine.  This
  Bjorn> is with firmware version

  Bjorn>     W460GXBS2.86E.0117C.P09.200108091154

  Bjorn> This is the only BIOS version I found mentioned on
  Bjorn> www.hp.com, so I assume it's the latest official version.

I'm all for the patch then.

	--david
