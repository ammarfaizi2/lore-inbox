Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264951AbTIDMlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTIDMlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:41:39 -0400
Received: from ozlabs.org ([203.10.76.45]:58003 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264951AbTIDMli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:41:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.13051.836875.270440@nanango.paulus.ozlabs.org>
Date: Thu, 4 Sep 2003 22:41:31 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <Pine.GSO.4.21.0309041420460.8244-100000@waterleaf.sonytel.be>
References: <16215.7181.755868.593534@nanango.paulus.ozlabs.org>
	<Pine.GSO.4.21.0309041420460.8244-100000@waterleaf.sonytel.be>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven writes:

> `ioremap is meant for PCI memory space only'

Did I say that, or someone else? :)  ioremap predates PCI support by a
long way IIRC...

Paul.
