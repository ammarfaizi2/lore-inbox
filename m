Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTFAIGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 04:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTFAIGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 04:06:22 -0400
Received: from chello062179076241.chello.pl ([62.179.76.241]:20126 "EHLO
	witch.nbox.pl") by vger.kernel.org with ESMTP id S261702AbTFAIGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 04:06:21 -0400
Date: Sun, 1 Jun 2003 10:19:35 +0200
From: Daniel Podlejski <underley@underley.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx problem
Message-ID: <20030601081935.GA20426@witch.underley.eu.org>
References: <20030531165945.GA5561@witch.underley.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531165945.GA5561@witch.underley.eu.org>
X-GPG: 1024D/21220D85 1261 0C43 E614 C0D8 D463 EF9B F1EA F4B4 2122 0D85
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Podlejski wrote:
[...]
: I have Adaptec SCSI controler, which with 2.4.20-ac2 boots ok:
: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
: scsi0:0:0:0: Cmd aborted from QINFIFO
: aic7xxx_abort returns 0x2002
: scsi0: target 14 using 8bit transfers
: scsi0: target 14 using asynchronous transfers
: ====================================================================
: 
: Any ideas to fix ?

After switch off APIC support works fine.

-- 
Daniel Podlejski <underley@underley.eu.org>
   ... You can check out any time you like
   But you can never leave ...
