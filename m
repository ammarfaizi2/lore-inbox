Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWGBRvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWGBRvK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWGBRvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:51:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21137 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932454AbWGBRvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:51:08 -0400
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59:
	undefined reference to `__stack_chk_fail'
From: Arjan van de Ven <arjan@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44A80614.3090802@zytor.com>
References: <fa.iPhEst5K48JbrGWRr3l3/GEBesY@ifi.uio.no>
	 <fa.iffnN5wM1UwqtCYhmqLAkGCMC2o@ifi.uio.no> <44A802FE.2020203@shaw.ca>
	 <44A80614.3090802@zytor.com>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 19:51:03 +0200
Message-Id: <1151862663.3111.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There is a good answer to that question, and that is, the kernel is the 
> special case.  It DOES make sense to let the distribution set the 
> default to whatever they think the end user should use for applications. 

yeah.. but it's called "CFLAGS environment variable" :-)


