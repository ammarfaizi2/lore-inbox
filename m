Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422754AbWJFRTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422754AbWJFRTK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWJFRTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:19:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25273 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422754AbWJFRTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:19:09 -0400
Subject: Re: [PATCH] [PATCH] Rename pdc_init
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061006170741.GK2563@parisc-linux.org>
References: <11601511393703-git-send-email-matthew@wil.cx>
	 <4526876A.5090103@garzik.org>
	 <1160155822.1607.110.camel@localhost.localdomain>
	 <20061006170741.GK2563@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 18:43:55 +0100
Message-Id: <1160156635.1607.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-06 am 11:07 -0600, ysgrifennodd Matthew Wilcox:
> > Can you cc me the patch as well ?
> 
> Um, I did.  Did your spamfilter eat it?

Ah found it, no my filters filed it under parisc 8)

"NAK" to the patch as is because the other drivers for consistency use
the same prefix for all functions for the same chip. I will however add
a TODO note to myself to rename them all properly next time I work on
that driver.

Alan

