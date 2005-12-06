Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVLFR5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVLFR5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVLFR5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:57:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4523 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964791AbVLFR5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:57:05 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Arjan van de Ven <arjan@infradead.org>
To: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051206175301.34596.qmail@web32110.mail.mud.yahoo.com>
References: <20051206175301.34596.qmail@web32110.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 18:56:49 +0100
Message-Id: <1133891809.4836.56.camel@laptopd505.fenrus.org>
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

On Tue, 2005-12-06 at 09:53 -0800, Vinay Venkataraghavan wrote:
> 
> 
> The motivation for the copy to user question is due to
> the handling of ioctl calls in the driver for a chip
> that is widely used. I just could not beleive that
> they would/could commit such a mistake. 

maybe it's time to give us the URL to the code...
your questions are getting detailed to the point that people who help
you should be able to see what the code is really doing..

