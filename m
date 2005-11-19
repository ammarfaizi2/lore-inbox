Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVKSKCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVKSKCT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 05:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVKSKCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 05:02:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45971 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750898AbVKSKCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 05:02:18 -0500
Subject: Re: Kernel panic: Machine check exception
From: Arjan van de Ven <arjan@infradead.org>
To: Avuton Olrich <avuton@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 19 Nov 2005 11:02:08 +0100
Message-Id: <1132394528.2829.4.camel@laptopd505.fenrus.org>
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

On Sat, 2005-11-19 at 01:45 -0800, Avuton Olrich wrote:
> My new computer has been locking up, sooner or later, since I've been
> using it. I happened to be at the console when it panic'd but it
> didn't leave me with many details.


does it happen without the nvidia binary module as well?


