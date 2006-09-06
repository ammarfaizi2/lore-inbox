Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWIFH0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWIFH0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWIFH0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:26:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7604 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751237AbWIFH0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:26:13 -0400
Subject: Re: PATA drivers queued for 2.6.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <44FDE2A0.3080705@tmr.com>
References: <44FC0779.9030405@garzik.org>
	 <1157371363.30801.31.camel@localhost.localdomain>
	 <44FDE2A0.3080705@tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 06 Sep 2006 08:48:55 +0100
Message-Id: <1157528936.21513.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-05 am 16:48 -0400, ysgrifennodd Bill Davidsen:
> I still use that interface, although I can't say it's critical if I 
> can't upgrade at some point. There are some other users in the local UG, 
> but they are probably not ever going to upgrade.

Currently paride is stand alone so it would be pretty hard to break
providing nothing else changes around it. I don't think its in danger of
going away, just of not improving.

Alan
