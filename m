Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTEOFln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTEOFln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:41:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263855AbTEOFlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:41:40 -0400
Message-ID: <2418.4.64.196.31.1052978067.squirrel@www.osdl.org>
Date: Wed, 14 May 2003 22:54:27 -0700 (PDT)
Subject: Re: [PATCH] __optional and __keep
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rusty@rustcorp.com.au>
In-Reply-To: <20030515021624.B814B2C017@lists.samba.org>
References: <20030515021624.B814B2C017@lists.samba.org>
X-Priority: 3
Importance: Normal
Cc: <torvalds@transmeta.com>, <akpm@zip.com.au>, <rth@twiddle.net>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi all!
>
> Does anyone else find __attribute_used__ confusing, or is it just me? In the
> tradition of likely() and unlikely(), I think __optional and __keep are
> clearer.
>
> Thoughts?
> Rusty.
> --

Yes, I thought that we had already hashed thru this one time.
I'm fine with the current naming.

~Randy



