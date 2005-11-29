Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVK2LYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVK2LYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 06:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVK2LYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 06:24:16 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:14857 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751039AbVK2LYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 06:24:15 -0500
Date: Tue, 29 Nov 2005 22:24:11 +1100
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 aes asm typo fix
Message-ID: <20051129112411.GA20131@gondor.apana.org.au>
References: <200511241507.01668.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511241507.01668.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 03:07:01PM +0200, Denis Vlasenko wrote:
> * fix typo (128 -> 192,256 bits)
> * nano-optimization (copied from x86_86)
> 
> Run tested.

Patch looks good.  I've applied it to cryptodev.  Thanks Denis.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
