Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWGARNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWGARNn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWGARNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:13:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32668 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751159AbWGARNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:13:42 -0400
Subject: Re: Eeek! page_mapcount(page) went negative! (-1)
From: Arjan van de Ven <arjan@infradead.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44A6AB99.8060407@gentoo.org>
References: <44A6AB99.8060407@gentoo.org>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 19:07:00 +0200
Message-Id: <1151773620.3195.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 18:06 +0100, Daniel Drake wrote:
> A user at http://bugs.gentoo.org/138366 reported a one-off crash on x86 
> with 2.6.16.19. Here's hoping it might be useful to somebody:

does this happen too when the user stops using the binary nvidia driver?


