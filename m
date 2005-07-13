Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVGMSIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVGMSIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVGMSFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:05:05 -0400
Received: from mta01.mail.t-online.hu ([195.228.240.50]:978 "EHLO
	mta01.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261539AbVGMSDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:03:40 -0400
Subject: Re: [PATCH 0/19] Kconfig I18N completion
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org>
References: <1121273456.2975.3.camel@spirit>
	 <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Jul 2005 20:03:38 +0200
Message-Id: <1121277818.2975.68.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Linus Torvalds wrote:
> On Wed, 13 Jul 2005, Egry Gábor wrote:
> > 
> > The following patches complete the "Kconfig I18N support" patch by
> > Arnaldo. 
> 
> No, I really don't want this.
> 
> I was told that the whole point of Arnaldo's work was that the actual po 
> files etc wouldn't need to be with the kernel, and could be a separate 
> package, maintained separately. Now I'm seeing patches that seem to make 
> that a lie.

Hmm, what .po files do you say about? I didn't send the translations of
Kconfig files. Unfortunetly Arnaldo's patch is incomplete. If you like
the unfinished things please drop my patches.

Gabor


