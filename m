Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751934AbWCNBSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWCNBSN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbWCNBSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:18:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62678 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751934AbWCNBSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:18:11 -0500
Subject: Re: New libata PATA patch for 2.6.16-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603131713.31411.s0348365@sms.ed.ac.uk>
References: <1142262431.25773.25.camel@localhost.localdomain>
	 <200603131639.51594.s0348365@sms.ed.ac.uk>
	 <200603131713.31411.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Mar 2006 01:24:17 +0000
Message-Id: <1142299457.25773.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-13 at 17:13 +0000, Alistair John Strachan wrote:
> 
> However, I just tried the same driver on my desktop PC (4xSATA HDs, 1xPATA) 
> and I get the following periodically (when the PATA device is NOT being 
> used):
> 
Can you try the vanilla rc6 kernel to check, and if it does it then let
Jeff Garzik known ASAP - especially if rc4 was ok.

> ata1: irq trap

