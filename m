Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUKHBTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUKHBTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUKHBTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 20:19:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:2960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261723AbUKHBTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 20:19:06 -0500
Message-ID: <418EC948.2080506@osdl.org>
Date: Sun, 07 Nov 2004 17:18:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ptb@inv.it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel analyser to detect sleep under spinlock
References: <200411072314.iA7NEM119415@inv.it.uc3m.es>
In-Reply-To: <200411072314.iA7NEM119415@inv.it.uc3m.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter T. Breuer wrote:
>  ftp://ųboe.it.uc3m.es/pub/Programs/c-1.2.tgz

That URL fails for me... is it correct?

> To use the application, compile and then use "c" in place of
> "gcc" on a typical kernel compile line.
> 
> This is currently tested only on kernel 2.4 and probably will need some
> slight mods to the parser for kernel 2.6 code, as it has to
> inverse engineer some of the assembler produced by macros in kernel
> headers.
> 
> Here's some typical output ...


-- 
~Randy
