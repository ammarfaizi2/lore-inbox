Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUHIWTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUHIWTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUHIWTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:19:23 -0400
Received: from the-village.bc.nu ([81.2.110.252]:40651 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267314AbUHIWTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:19:12 -0400
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, bjorn.helgaas@hp.com, akpm@osdl.org,
       ehm@cris.com, grif@cs.ucr.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040809141155.0c94b8c4.davem@redhat.com>
References: <200408091252.58547.bjorn.helgaas@hp.com>
	 <20040809210335.A9711@infradead.org>
	 <20040809141155.0c94b8c4.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092086162.14766.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 22:16:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 22:11, David S. Miller wrote:
> You could remove the qlogicfc driver if you really wanted, by providing
> a config option that would provide qlogicfc compatible device numbering
> in the qla2xxx driver.
> 
> So implement that instead of bitching about me trying to keep people's
> systems functional, ok? :-)

Easier to just mark it OBSOLETE and take it out in a year or so

