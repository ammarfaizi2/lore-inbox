Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTHZKYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbTHZKYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:24:09 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:61197 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263612AbTHZKYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:24:04 -0400
Date: Tue, 26 Aug 2003 20:23:39 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Tom Vier <tmv@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: cryptoapi doesn't build
In-Reply-To: <20030826015256.GA9317@zero>
Message-ID: <Mutt.LNX.4.44.0308262023030.4908-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003, Tom Vier wrote:

> 2.4.22:
> 
> In file included from api.c:21:
> internal.h:19:28: asm/kmap_types.h: No such file or directory
> In file included from api.c:21:
> internal.h:24: error: return type is an incomplete type
> internal.h: In function rypto_kmap_type':
> internal.h:25: error: invalid use of undefined type num km_type'
> internal.h:25: warning: eturn' with a value, in function returning void
> 
> iirc, 2.4.21 had the same problem.
> 

What architecture did you see this on?


- James
-- 
James Morris
<jmorris@intercode.com.au>

