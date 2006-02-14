Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422828AbWBNXRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422828AbWBNXRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWBNXRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:17:23 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25536 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422828AbWBNXRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:17:23 -0500
Subject: Re: PATCH: rio driver, boot code (1 of 3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602141302320.3691@g5.osdl.org>
References: <1139944938.11979.5.camel@localhost.localdomain>
	 <200602141938.12041.s0348365@sms.ed.ac.uk>
	 <1139947720.11979.15.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0602141302320.3691@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 23:20:09 +0000
Message-Id: <1139959209.11979.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-14 at 13:02 -0800, Linus Torvalds wrote:
> It looks like the indent was done _after_ patch #1 was applied, but then 
> the result was diffed against the state _before_ patch #1 was applied.

Umm yes, so just apply #2 and #3. Sorry about that. I can send you a
single patch with the lot if you want but I didn't archive the inbetween
states

