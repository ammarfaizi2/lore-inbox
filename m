Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUHPVM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUHPVM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 17:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUHPVM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 17:12:58 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:14486 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S265207AbUHPVM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 17:12:57 -0400
Date: Mon, 16 Aug 2004 14:12:52 -0700
Message-Id: <200408162112.i7GLCqTB030682@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] waitid system call
In-Reply-To: Michael Kerrisk's message of  Monday, 16 August 2004 19:15:37 +0200 <10992.1092676537@www28.gmx.net>
X-Zippy-Says: My nose feels like a bad Ronald Reagan movie...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Precisely what kernel version was the patch against?  

It is against 2.6.8.1.

> I've (twice) tried applying the patch against 2.6.8.1 and building the
> kernel.  The build succeeds, but I am running into a strange kernel panic
> ("Unable to mount root fs") when I try to boot the resulting kernel.
> (Compiling and booting 2.6.8.1 on the same x86 machine works fine.)

Well, it sure works fine for me.  Unless someone else can reproduce your
issue, you'll have to look into it yourself.  I don't discount the
likelihood it's a bug caused by my patch, but such an error is so far
afield that there is no way for me to guess at what you might be seeing.


Thanks,
Roland

