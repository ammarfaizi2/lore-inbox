Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVHNJGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVHNJGU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 05:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVHNJGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 05:06:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48078 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932374AbVHNJGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 05:06:19 -0400
Date: Sun, 14 Aug 2005 10:06:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: Chris Wedgwood <cw@f00f.org>, Henrik Brix Andersen <brix@gentoo.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050814090616.GA15859@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olaf Hering <olh@suse.de>, Chris Wedgwood <cw@f00f.org>,
	Henrik Brix Andersen <brix@gentoo.org>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <1123969015.13656.13.camel@sponge.fungus> <20050813232519.GA20256@infradead.org> <20050813234322.GA30563@suse.de> <20050814030256.GA21147@taniwha.stupidest.org> <20050814090324.GA9871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814090324.GA9871@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 11:03:24AM +0200, Olaf Hering wrote:
>  On Sat, Aug 13, Chris Wedgwood wrote:
> 
> > On Sun, Aug 14, 2005 at 01:43:22AM +0200, Olaf Hering wrote:
> > 
> > > It is used for /class/misc/$name/dev
> > 
> > Ick.  I would almost suggest we change that were it not too late.  I
> > think keeping the decription is useful and desirable.
> 
> Where is the description visible?

/proc/misc
