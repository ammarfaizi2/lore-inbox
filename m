Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWIFTGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWIFTGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWIFTGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:06:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13246 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751224AbWIFTGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:06:51 -0400
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
In-Reply-To: <20060906182733.GJ2558@parisc-linux.org>
References: <44FC193C.4080205@openvz.org>
	 <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
	 <20060906182733.GJ2558@parisc-linux.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 06 Sep 2006 21:06:19 +0200
Message-Id: <1157569579.29093.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 12:27 -0600, Matthew Wilcox wrote:
> On Wed, Sep 06, 2006 at 11:24:05AM -0700, Linus Torvalds wrote:
> > If MIPS and parisc don't matter for the stable tree (very possible - there 
> > are no big commercial distributions for them), then dammit, neither should 
> > ia64 and sparc (there are no big commercial distros for them either). 
> 
> Erm, RHEL and SLES both support ia64.

but neither use -stable.


