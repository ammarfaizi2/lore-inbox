Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTGXMYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 08:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTGXMYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 08:24:02 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:25051 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S263637AbTGXMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 08:23:10 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200307241237.h6OCbBNn010280@wildsau.idv.uni.linz.at>
Subject: Re: how to PAE enable kernel?
In-Reply-To: <200307241233.h6OCX8UF010106@wildsau.idv.uni.linz.at>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Date: Thu, 24 Jul 2003 14:37:11 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> hi,
> 
> we have a system with 4G, however, only approx 1G will be used.
> dmesg issues the hint "use a PAE enabled kernel". silly question,
> but how do I PAE enable a kernel? I have found a lot of messages
> about PAE enabled kernels on the net, but not *how* to enable this
> feature.
> 
> any hints please?

oh.

I see. I have to use enable 64GB, since 4 of the 4G lives above the
the 4G physical address limit. correct? sorry for interrupting ...
 
> thanks in advance,
> herbert
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
