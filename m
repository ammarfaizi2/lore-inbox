Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWI3EJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWI3EJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 00:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWI3EJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 00:09:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28118 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750768AbWI3EJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 00:09:12 -0400
Date: Fri, 29 Sep 2006 21:08:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Ollie Wild <aaw@google.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, dhollis@davehollis.com,
       Jason Lunz <lunz@falooley.org>
Subject: Re: [PATCH 2/2] UML - Don't roll my own random MAC generator
Message-Id: <20060929210857.fffc1e5d.akpm@osdl.org>
In-Reply-To: <20060930035234.GB10307@ccure.user-mode-linux.org>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
	<65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
	<20060929153853.9bab3ca7.akpm@osdl.org>
	<20060930035234.GB10307@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:52:34 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> > Jeff, could we pleeeeeze arrange for UML's `make allmodconfig' to work, and
> > to continue to work?
> 
> It works for me - I haven't built -mm2 on x86_64 yet, but I'll check that.

that was mainline.  Perhaps a toolchain thing?
