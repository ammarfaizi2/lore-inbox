Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUH1Se3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUH1Se3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUH1SeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:34:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:2746 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267605AbUH1Sda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:33:30 -0400
Date: Sat, 28 Aug 2004 11:31:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] move ghash.h were it does less harm
Message-Id: <20040828113133.15f335b1.akpm@osdl.org>
In-Reply-To: <20040828105512.GA11067@lst.de>
References: <20040828105512.GA11067@lst.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> grmp, UML folks re-added ghash.h despite beeing told repeatedly not to
>  do so.

Oh crap, sorry, I lost track of that.

>  At least move it to arch/um/ so people don't start to use it
>  again when they are on similar drugs as thge UML people.

We could just delete the file - that'd get Jeff's attention ;)
