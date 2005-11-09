Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbVKIWPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbVKIWPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKIWPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:15:12 -0500
Received: from ozlabs.org ([203.10.76.45]:33493 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030446AbVKIWPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:15:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.29935.352768.742780@cargo.ozlabs.ibm.com>
Date: Thu, 10 Nov 2005 09:15:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: 64K pages support
In-Reply-To: <20051109172125.GA12861@lst.de>
References: <1130915220.20136.14.camel@gaston>
	<1130916198.20136.17.camel@gaston>
	<20051109172125.GA12861@lst.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> Booting current mainline with 64K pagesize enabled gives me a purple (!)
> screen early during boot.

Cool!

Is this on a G5, or what sort of machine?  What .config are you using?

Paul.
