Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTIJMKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTIJMKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:10:45 -0400
Received: from mid-1.inet.it ([213.92.5.18]:7378 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S262813AbTIJMKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:10:44 -0400
Message-ID: <03ba01c37795$21aca1a0$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910120729.C14352@devserv.devel.redhat.com> <20030910103752.GC21313@mail.jlokier.co.uk> <20030910124151.C9878@devserv.devel.redhat.com> <02bc01c37789$ebfa9a40$5aaf7450@wssupremo> <3F5F0820.3090003@cyberone.com.au> <036a01c3778e$ebadc080$5aaf7450@wssupremo> <3F5F0E9D.6090606@cyberone.com.au>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 14:14:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes you're right. Just search for it. It would be interesting to compare
> them with your implementation.
> I'm not too sure, I was just pointing you to zero copy pipes because
> they did have some disadvantages which is why they weren't included in
> the kernel. Quite possibly your mechanism doesn't suffer from these.

Ok. I'll search for them.

> What would really help convince everyone is, of course, "real world"
> benchmarks. I like your ideas though ;)

Thanks.

Luca
