Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbUCEOxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUCEOw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:52:59 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:9170 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S262463AbUCEOw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:52:58 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binutils 2.15.90.0.1 break ia64 kernel crosscompiling
In-Reply-To: <1woEF-7Yx-7@gated-at.bofh.it>
References: <1woEF-7Yx-7@gated-at.bofh.it>
Date: Fri, 5 Mar 2004 15:52:52 +0100
Message-Id: <E1AzGh2-00006C-Nf@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Mar 2004 15:40:09 +0100, you wrote in linux.kernel:

> upgraded my Cross Compiling Toolchain[1] to binutils 2.15.90.0.1, 

Experimental binutils release...

> here is th funny part of the complete error log[2]
>
> ------------------------------------------------------------------
>   {standard input}: Assembler messages:
>   {standard input}:1268: Internal error!
>   Assertion failure in md_assemble at config/tc-ia64.c line 10013.
>   Please report this bug.
> ------------------------------------------------------------------

binutils bug. Report to them.

-- 
Ciao,
Pascal
