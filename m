Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVCEWYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVCEWYW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCEWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:24:15 -0500
Received: from mail-gw1.york.ac.uk ([144.32.128.246]:52730 "EHLO
	mail-gw1.york.ac.uk") by vger.kernel.org with ESMTP id S261310AbVCEWXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:23:35 -0500
Subject: Re: RivaFB and GeForce FX
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
To: ods15 <ods5926@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110043216.6780.14.camel@host-172-19-5-120.sns.york.ac.uk>
References: <1110023602.7572.24.camel@host-172-19-5-120.sns.york.ac.uk>
	 <f470889705030505089a4d8df@mail.gmail.com>
	 <1110038232.7572.44.camel@host-172-19-5-120.sns.york.ac.uk>
	 <1110043216.6780.14.camel@host-172-19-5-120.sns.york.ac.uk>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 21:14:33 +0000
Message-Id: <1110057273.2464.9.camel@host-172-19-5-120.sns.york.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've tried adding the format and vpllB but I can't see any difference.

...

> I'll get 2.6.6 (the version your patch applies to) and try with and
> without your full patch.  Hopefully I'll be able to see the difference.
> Otherwise I might have to ask you to try the trivial and full patches
> I'm using for 2.6.11.

I see gross screen corruption without the full patch on 2.6.6, but this
is gone in 2.6.11. 

I suspect I am preempting someone elses work, but they haven't (yet)
come forward, and as I said I haven't been able to get in touch with the
drivers maintainer.  I'll ask the framebuffer layer maintainer about it.
I've not CC'd him in this email because my habit of stripping quotes has
left it without context.

