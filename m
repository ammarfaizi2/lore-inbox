Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269959AbRHJRle>; Fri, 10 Aug 2001 13:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269960AbRHJRlY>; Fri, 10 Aug 2001 13:41:24 -0400
Received: from [64.7.140.42] ([64.7.140.42]:12249 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S269959AbRHJRlK>;
	Fri, 10 Aug 2001 13:41:10 -0400
Message-ID: <034401c121c4$3d2005e0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Caleb Tennis" <caleb@aei-tech.com>, <linux-kernel@vger.kernel.org>,
        <tytso@mit.edu>
In-Reply-To: <01081010190800.03758@pete.aei-tech.com> <017801c121b5$e254f3e0$294b82ce@connecttech.com> <01081012213100.08017@pete.aei-tech.com>
Subject: Re: [PATCH] serial.c to support ConnectTech Blueheat PCI
Date: Fri, 10 Aug 2001 13:45:25 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Caleb Tennis" <caleb@aei-tech.com>
> I'm quite pleased at the support ConnectTech has for this product.  We are
> planning on purchasing more in the future.

Thank you.

> progression), and thought it may be valuable to submit a patch related to
the
> latest kernel.

Again, thanks.

> There really isn't a good way around this patch - I understand Ted's
concern
> on board specific functionality, but it is quite extendable to other
485/232
> combination boards as well.  I sure hope it makes it into the kernel at
some
> point, but if not I'll continue hand patching away :)

My first version of the patch was not as well designed as the current
one; I reworked it a fair bit to make it extensible and keep the
CTi-specific code strictly confined to a few subroutines. I'm hoping it
makes it in too.

Hopefully we'll hear from Ted shortly.

..Stu


