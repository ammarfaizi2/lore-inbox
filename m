Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267978AbUGaRYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbUGaRYG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUGaRYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:24:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:7918 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267979AbUGaRXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:23:51 -0400
X-Authenticated: #1725425
Date: Sat, 31 Jul 2004 19:29:11 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Matt Mackall <mpm@selenic.com>
Cc: daw@cs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-Id: <20040731192911.00f68d5e.Ballarin.Marc@gmx.de>
In-Reply-To: <20040731020534.GX5414@waste.org>
References: <1091193219.11944.17.camel@leto.cs.pocnet.net>
	<200407310044.i6V0iOZe032440@taverner.CS.Berkeley.EDU>
	<20040731020534.GX5414@waste.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 21:05:34 -0500
Matt Mackall <mpm@selenic.com> wrote:


> 
> Ideally, we'd ship a requirements and specification document that
> describes the security trade-offs of cryptoloop/dm-crypt in some
> detail. There are way too many unstated assumptions here.
> 

Indeed. I have just tried to start a discussion of the future design goals
on the dm-crypt mailinglist.

If you are not subscribed see
http://article.gmane.org/gmane.linux.kernel.device-mapper.dm-crypt/379

Regards
