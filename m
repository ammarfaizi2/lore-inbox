Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTLJCHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTLJCHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:07:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:7390 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263082AbTLJCHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:07:41 -0500
Date: Tue, 9 Dec 2003 17:38:09 -0800
From: Greg KH <greg@kroah.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [USB] Fix connect/disconnect race
Message-ID: <20031210013809.GO2279@kroah.com>
References: <20031130074814.GA13002@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130074814.GA13002@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 06:48:14PM +1100, Herbert Xu wrote:
> Hi Greg:
> 
> This patch was integrated by you in 2.4 six months ago.  Unfortunately
> it never got into 2.5.  Without it you can end up with crashes such
> as http://bugs.debian.org/218670

Thanks, I've applied this and will send it on.

greg k-h
