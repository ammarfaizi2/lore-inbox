Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbULVME0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbULVME0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 07:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbULVMEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 07:04:24 -0500
Received: from [213.146.154.40] ([213.146.154.40]:58545 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261976AbULVMBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 07:01:54 -0500
Date: Wed, 22 Dec 2004 12:01:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041222120153.GA10710@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <1103544944.4133.7.camel@laptopd505.fenrus.org> <20041220132012.GA6046@localhost> <1103704157.4131.5.camel@laptopd505.fenrus.org> <41C9370C.1070905@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C9370C.1070905@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 09:57:48AM +0100, Stefan Richter wrote:
> Arjan van de Ven wrote:
> >On Mon, 2004-12-20 at 14:20 +0100, Arne Caspari wrote:
> >>>are you going to submit that driver for inclusion any time soon ?
> >>What would be the benefit if I do so? 
> >you get a lot more eyes on the code; other people help adjusting your
> >code to new apis etc etc
> 
> ...which works best if submitters of patches remember to make use of the 
> communication channels suggested in MAINTAINERS.

Except when those are disfunct, and hord their changes in CVS or SVN
repositories..

