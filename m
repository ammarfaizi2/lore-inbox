Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbUKDM1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbUKDM1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbUKDMYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:24:41 -0500
Received: from canuck.infradead.org ([205.233.218.70]:530 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262191AbUKDMXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:23:15 -0500
Subject: Re: [PATCH 7/12] meye: the driver is no longer experimental and
	depends on PCI
From: Arjan van de Ven <arjan@infradead.org>
To: Stelian Pop <stelian@popies.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041104114904.GV3472@crusoe.alcove-fr>
References: <20041104111231.GF3472@crusoe.alcove-fr>
	 <20041104111613.GM3472@crusoe.alcove-fr>
	 <20041104114126.GA31736@infradead.org>
	 <20041104114904.GV3472@crusoe.alcove-fr>
Content-Type: text/plain
Message-Id: <1099570980.16640.6.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 04 Nov 2004 13:23:00 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Of course, the actual hardware does exist only on C1V* Vaio Laptops,
> which can accept at most 256 MB RAM


... but distros enable PAE anyway for things like NX and for general
reasons (distros need to support > 4Gb ram of course ;)

