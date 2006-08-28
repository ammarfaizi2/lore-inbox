Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWH1GYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWH1GYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWH1GYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:24:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932357AbWH1GYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:24:43 -0400
Date: Sun, 27 Aug 2006 23:24:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: Linux v2.6.18-rc5
Message-Id: <20060827232437.821110f3.akpm@osdl.org>
In-Reply-To: <20060828061940.GA12671@aepfle.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	<20060827231421.f0fc9db1.akpm@osdl.org>
	<20060828061940.GA12671@aepfle.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 08:19:40 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> On Sun, Aug 27, Andrew Morton wrote:
> 
> > On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > Linux 2.6.18-rc5 is out there now
> > 
> > (Reporters Bcc'ed: please provide updates)
> 
> > Subject: oops in __delayacct_blkio_ticks with 2.6.18-rc4
> 
> This patch is supposed to fix it.
> 
> http://lkml.org/lkml/2006/8/22/245
> http://lkml.org/lkml/2006/8/24/299

Yes, there are two delay-accounting fixes pending - this and a memory leak. 
Shailabh is off preparing the final versions (I hope).

