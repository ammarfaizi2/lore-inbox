Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTICCwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 22:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTICCwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 22:52:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:19104 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261409AbTICCwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 22:52:40 -0400
Message-ID: <32886.4.4.25.4.1062557559.squirrel@www.osdl.org>
Date: Tue, 2 Sep 2003 19:52:39 -0700 (PDT)
Subject: RE: Compressed VMLINUX Kernel
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <diskman@kc.rr.com>
In-Reply-To: <004801c371c1$fc64b0f0$6501a8c0@zephyr>
References: <004801c371c1$fc64b0f0$6501a8c0@zephyr>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was wondering, is there some method or utility that will allow me to
> compress my kernel (vmlinux)? I was running an alpha and bzImage and zImage
> don’t work.  I read all the mans that I could lay my grubby little hands on
> but none of them mentioned HOW one is the compress a vmlinux kernel.
> The reason ask this is, I boot to linux using an OLD IDE drive and it takes
> sometime to read a 7mb file. I noticed that the original kernel
> (Redhat/Compaq derivative) was compressed and somewhat smaller, about less
> than half the size. Thanks, Will L G

Kernel version?

In 2.4.22 and 2.6.0-test, there are targets for ALPHA called vmlinux.gz.
Have you tried 'make vmlinux.gz' ?

~Randy



