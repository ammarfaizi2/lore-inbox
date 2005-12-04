Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVLDHwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVLDHwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 02:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVLDHwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 02:52:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42909 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750811AbVLDHwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 02:52:14 -0500
Subject: Re: Make vm_insert_page() available to NVidia module
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200512040559.jB45xUPw000371@hera.kernel.org>
References: <200512040559.jB45xUPw000371@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 08:52:11 +0100
Message-Id: <1133682732.5188.0.camel@laptopd505.fenrus.org>
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

On Sat, 2005-12-03 at 21:59 -0800, Linux Kernel Mailing List wrote:
> tree 316a9e9ea22c49de5bef8af6a4b4557353f7d36a
> parent 0ceaacc9785fedc500e19b024d606a82a23f5372
> author Linus Torvalds <torvalds@g5.osdl.org> Sun, 04 Dec 2005 12:48:11 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 04 Dec 2005 12:48:11 -0800
> 
> Make vm_insert_page() available to NVidia module

is this a statement that you officially tolerate binary only modules?


