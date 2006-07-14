Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWGNTjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWGNTjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWGNTjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:39:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5298 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422729AbWGNTjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:39:53 -0400
Subject: Re: 2.6.18 Headers - Long
From: Arjan van de Ven <arjan@infradead.org>
To: Jim Gifford <maillist@jg555.com>
Cc: David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org
In-Reply-To: <44B7F062.8040102@jg555.com>
References: <44B443D2.4070600@jg555.com>
	 <1152836749.31372.36.camel@shinybook.infradead.org>
	 <44B6FEDE.4040505@jg555.com> <1152903332.3191.87.camel@pmac.infradead.org>
	 <44B7F062.8040102@jg555.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 21:39:46 +0200
Message-Id: <1152905987.3159.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 12:28 -0700, Jim Gifford wrote:
> Unfortunately, a lot programs out there are using page.h, and a lot of 
> people are using that in their programs. 

.... and they're all broken....
(hint: page size on many platforms is a kernel compile option, eg not a
constant)

