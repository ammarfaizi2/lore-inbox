Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVGMTFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVGMTFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVGMTDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:03:51 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:291 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262340AbVGMTBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:01:05 -0400
Date: Wed, 13 Jul 2005 20:48:53 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Egry G?bor <gaboregry@t-online.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
Message-ID: <20050713204852.GB16284@mars.ravnborg.org>
References: <1121273456.2975.3.camel@spirit> <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org> <1121277818.2975.68.camel@spirit> <20050713201147.GA23746@mars.ravnborg.org> <1121280104.2975.84.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121280104.2975.84.camel@spirit>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, the patch 19/19 contains the translation of configuration
> interfaces ([x|g|menu]config) and it is only 23 kb.

The kernel proper are not to be clutered with a huge number of .po
files. They do not belong in the kernel at the first place.

	Sam
