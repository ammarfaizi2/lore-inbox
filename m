Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTIWXKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTIWXKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:10:15 -0400
Received: from pop.gmx.net ([213.165.64.20]:13977 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261670AbTIWXKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:10:10 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2003 01:10:18 +0200
MIME-Version: 1.0
Subject: Re: How to understand an oops?
Message-ID: <3F70EEFA.14060.1665A54C@localhost>
In-reply-to: <20030923111621.5b583d62.rddunlap@osdl.org>
References: <3F709F7E.28657.152F28ED@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> | > Are there a few informative lines missing before the Oops: line below?
> 
> I was expecting more like (cut from source code):
> 
> 	("Unable to handle kernel NULL pointer dereference");
> or
> 	("Unable to handle kernel paging request");
> and
> 	(" at virtual address %08lx\n",address);
> 	(" printing eip:\n");
> 	("%08lx\n", regs->eip);
> 	("*pde = %08lx\n", page);
> 	("*pte = %08lx\n", page);
> 

No output of that kind. Only the Oops posted.

> ... 
> 
> In the meantime, you haven't tried the other mailing lists that
> I suggested....
> 

In the meantime I did.

>...

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

