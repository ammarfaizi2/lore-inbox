Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132537AbQLQLV5>; Sun, 17 Dec 2000 06:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132536AbQLQLVr>; Sun, 17 Dec 2000 06:21:47 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:21011 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132537AbQLQLVh>;
	Sun, 17 Dec 2000 06:21:37 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: Your message of "Sun, 17 Dec 2000 10:44:09 -0000."
             <Pine.LNX.4.30.0012171039400.14423-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Dec 2000 21:51:04 +1100
Message-ID: <2181.977050264@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000 10:44:09 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>The conditional compilation is far more obvious to people than subtle
>issues with link order. So I prefer to avoid the latter at all costs.

The rest of the kernel already depends totally on these "subtle" issues
with link order.  Why should mtd be different?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
