Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbUKDNQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbUKDNQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 08:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUKDNQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 08:16:13 -0500
Received: from canuck.infradead.org ([205.233.218.70]:23314 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262216AbUKDNQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 08:16:12 -0500
Subject: Re: [PATCH 7/12] meye: the driver is no longer experimental and
	depends on PCI
From: Arjan van de Ven <arjan@infradead.org>
To: Stelian Pop <stelian@popies.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041104123210.GW3472@crusoe.alcove-fr>
References: <20041104111231.GF3472@crusoe.alcove-fr>
	 <20041104111613.GM3472@crusoe.alcove-fr>
	 <20041104114126.GA31736@infradead.org>
	 <20041104114904.GV3472@crusoe.alcove-fr>
	 <1099570980.16640.6.camel@laptop.fenrus.org>
	 <20041104123210.GW3472@crusoe.alcove-fr>
Content-Type: text/plain
Message-Id: <1099574162.16640.9.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 04 Nov 2004 14:16:02 +0100
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


> I thought that CONFIG_HIGHMEM64G is not cost-free and thus must
> be enabled only when needed...

having multiple kernels also isn't free... and there's a milion
different config options that cost/gain performance ;)


