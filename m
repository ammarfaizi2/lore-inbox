Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWH1GTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWH1GTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWH1GTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:19:54 -0400
Received: from natreg.rzone.de ([81.169.145.183]:27104 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S932348AbWH1GTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:19:54 -0400
Date: Mon, 28 Aug 2006 08:19:40 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060828061940.GA12671@aepfle.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <20060827231421.f0fc9db1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, Andrew Morton wrote:

> On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Linux 2.6.18-rc5 is out there now
> 
> (Reporters Bcc'ed: please provide updates)

> Subject: oops in __delayacct_blkio_ticks with 2.6.18-rc4

This patch is supposed to fix it.

http://lkml.org/lkml/2006/8/22/245
http://lkml.org/lkml/2006/8/24/299
