Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWJWRJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWJWRJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWJWRJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:09:13 -0400
Received: from smtp1.ist.utl.pt ([193.136.128.21]:65409 "EHLO smtp1.ist.utl.pt")
	by vger.kernel.org with ESMTP id S964906AbWJWRJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:09:12 -0400
From: Claudio Martins <ctpm@ist.utl.pt>
To: David Miller <davem@davemloft.net>
Subject: Unintended commit?
Date: Mon, 23 Oct 2006 18:09:08 +0100
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231809.09238.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

 I noticed that commit 4e8a5201506423e0241202de1349422af4260296 on Linus' tree 
titled "[PKT_SCHED] netem: Orphan SKB when adding to queue." also touches the 
file "drivers/pci/quirks.c", which seems unrelated.

 Was this intentional? 
 If so, then I'm sorry for the noise...

 Best regards

Claudio Martins

