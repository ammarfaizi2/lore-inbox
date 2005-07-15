Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263313AbVGOPAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263313AbVGOPAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 11:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbVGOPAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 11:00:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38113 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263313AbVGOPAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 11:00:35 -0400
Date: Fri, 15 Jul 2005 16:00:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-ID: <20050715150034.GA6192@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050715013653.36006990.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> 
> (http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc3-mm1.gz until
> kernel.org syncs up)
> 
> 
> - Added the CKRM patches.  This is just here for people to look at at this
>   stage.

Andrew, do we really need to add every piece of crap lying on the street
to -mm?  It's far away from mainline enough already without adding obviously
unmergeable stuff like this.

