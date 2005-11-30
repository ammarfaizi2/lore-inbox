Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbVK3TZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbVK3TZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVK3TZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:25:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3778 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751509AbVK3TZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:25:50 -0500
Subject: Re: BUG in kernel checked out 24 hours ago
From: Arjan van de Ven <arjan@infradead.org>
To: Damien Wyart <damien.wyart@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051130192050.GA13596@localhost.localdomain>
References: <20051130192050.GA13596@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 20:25:46 +0100
Message-Id: <1133378746.2825.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 20:20 +0100, Damien Wyart wrote:
> Hello,
> 
> Please find the log from a BUG I encountered this evening while running
> a kernel I had checkouted from git and compiled arond 6pm UTC yesterday.
> The computer froze and I could reboot it with Sysrq.
> 
> Any comments welcome, notably about if this has been corrected since or
> not (I am not insider enough to be sure). I am currently compileing
> a freshly checkouted kernel to see if it runs better.

you should try without the nvidia module....


