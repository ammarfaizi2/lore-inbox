Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTDXEXC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbTDXEXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:23:01 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10709 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264402AbTDXEWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:22:51 -0400
Message-ID: <32992.4.64.197.106.1051158898.squirrel@www.osdl.org>
Date: Wed, 23 Apr 2003 21:34:58 -0700 (PDT)
Subject: Re: OOPS in Kmalloc
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <ramands@indiatimes.com>
In-Reply-To: <200304240344.JAA29170@WS0005.indiatimes.com>
References: <200304240344.JAA29170@WS0005.indiatimes.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>, <linux-newbie@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> i am getting OOPS in Kmalloc .
>
> void **data;
> qset = 1000;
>
> dptr->data = kmalloc(qset * sizeof(char *), GFP_KERNEL);
>
> what could the possible the cause of the error
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
As I am so fond of saying, it's almost always correct to indicate what
kernel version one if referring to in a problem report.

Please decode the oops output and post it here.

~Randy



