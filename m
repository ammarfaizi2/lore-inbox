Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVGMRnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVGMRnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVGMRl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:41:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261919AbVGMRlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:41:31 -0400
Date: Wed, 13 Jul 2005 10:41:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Egry_G=E1bor?= <gaboregry@t-online.hu>
cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
In-Reply-To: <1121273456.2975.3.camel@spirit>
Message-ID: <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org>
References: <1121273456.2975.3.camel@spirit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jul 2005, Egry Gábor wrote:
> 
> The following patches complete the "Kconfig I18N support" patch by
> Arnaldo. 

No, I really don't want this.

I was told that the whole point of Arnaldo's work was that the actual po 
files etc wouldn't need to be with the kernel, and could be a separate 
package, maintained separately. Now I'm seeing patches that seem to make 
that a lie.

		Linus
