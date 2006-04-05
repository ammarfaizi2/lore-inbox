Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWDEGtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWDEGtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 02:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWDEGtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 02:49:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751124AbWDEGtY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 02:49:24 -0400
Date: Tue, 4 Apr 2006 23:47:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, hpa@zytor.com,
       ebiederman@lnxi.com, dwmw2@infradead.org, tglx@linutronix.de,
       spse@secret.org.uk
Subject: Re: [Patch 0/3] Remove blkmtd
Message-Id: <20060404234758.66a70968.akpm@osdl.org>
In-Reply-To: <20060404092628.GA12277@wohnheim.fh-wedel.de>
References: <20060404092628.GA12277@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
> This patchset removed blkmtd in three steps:
> 1. Mark it as deprecated,
> 2. mark block2mtd, the replacement, as no longer experimental and
> 3. remove the driver.
> 
> Eric suggested sending patch 1 and 2 directly to Linus while leaving
> patch 3 in -mm as long as klibc remains there as well.  Andrew, do you
> prefer me to send the first two patches to Linus or will you rather do
> it yourself?
> 

That's all too much fuss.  Let's just zap it.
