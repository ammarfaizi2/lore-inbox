Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWGNT6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWGNT6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWGNT6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:58:18 -0400
Received: from canuck.infradead.org ([205.233.218.70]:60603 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1422653AbWGNT6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:58:18 -0400
Subject: Re: 2.6.18 Headers - Long
From: David Woodhouse <dwmw2@infradead.org>
To: Jim Gifford <maillist@jg555.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
In-Reply-To: <44B7F062.8040102@jg555.com>
References: <44B443D2.4070600@jg555.com>
	 <1152836749.31372.36.camel@shinybook.infradead.org>
	 <44B6FEDE.4040505@jg555.com> <1152903332.3191.87.camel@pmac.infradead.org>
	 <44B7F062.8040102@jg555.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 20:57:54 +0100
Message-Id: <1152907074.3191.90.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 12:28 -0700, Jim Gifford wrote:
> Unfortunately, a lot programs out there are using page.h, and a lot of 
> people are using that in their programs. The 2 program I know for sure 
> that use page.h are glibc and util-linux. 

I don't believe glibc does. It certainly copes fine with an empty page.h
on PowerPC.

-- 
dwmw2

