Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752389AbWCPQg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbWCPQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbWCPQg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:36:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2529 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752388AbWCPQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:36:25 -0500
Date: Thu, 16 Mar 2006 16:36:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316163621.GA7519@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net> <20060316163001.GA7222@infradead.org> <20060316083654.d802f3f3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316083654.d802f3f3.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > it makes the code longer and harder to read.  there's a reason the core
> > code doesn't use it, and the periphal code should do the same.
> 
> in your opinion.

of course.  but that it's not used in core code implies this opinion is
widely shared.

