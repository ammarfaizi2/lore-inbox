Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVGNByM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVGNByM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 21:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVGNByM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 21:54:12 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:23183 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261268AbVGNByL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 21:54:11 -0400
Date: Thu, 14 Jul 2005 03:42:11 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Egry G?bor <gaboregry@t-online.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
Message-ID: <20050714034211.GA27279@mars.ravnborg.org>
References: <1121273456.2975.3.camel@spirit> <20050713204500.GA16284@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713204500.GA16284@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> When I apply them to latest Linus tree I gett a few fuzz and a single
> reject. After fixing this and compiling I get a number of warnings and
> errors. I have not investigated the source of this.
I now see that I missed two patches in the serie.
I will try to reapply tomorrow.

	Sam
