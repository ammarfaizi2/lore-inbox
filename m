Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVGMUGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVGMUGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVGMUGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:06:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:29063 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262692AbVGMUEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:04:53 -0400
Date: Wed, 13 Jul 2005 22:04:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: =?ISO-8859-1?Q?Egry_G=E1bor?= <gaboregry@t-online.hu>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
In-Reply-To: <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0507132203360.23970@yvahk01.tjqt.qr>
References: <1121273456.2975.3.camel@spirit> <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The following patches complete the "Kconfig I18N support" patch by
>> Arnaldo. 
>
>I was told that the whole point of Arnaldo's work was that the actual po 
>files etc wouldn't need to be with the kernel, and could be a separate 

They in fact do not need to be with the kernel. It's just "bad timing" that 
the recently submitted patches do so.

>package, maintained separately. Now I'm seeing patches that seem to make 
>that a lie.



Jan Engelhardt
-- 
