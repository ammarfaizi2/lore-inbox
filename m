Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267963AbUHKK70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267963AbUHKK70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUHKK7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:59:25 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:33806 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267963AbUHKK7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:59:24 -0400
Date: Wed, 11 Aug 2004 11:59:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Ketrenos <jketreno@linux.intel.com>, Pavel Machek <pavel@suse.cz>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040811115912.A27530@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Ketrenos <jketreno@linux.intel.com>,
	Pavel Machek <pavel@suse.cz>,
	Jeff Chua <jeffchua@silk.corp.fedex.com>,
	Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com> <20040714115523.GC2269@elf.ucw.cz> <20040809201556.GB9677@louise.pinerecords.com> <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com> <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz> <4119F203.1070009@linux.intel.com> <20040811114437.A27439@infradead.org> <20040811105337.GC32420@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040811105337.GC32420@wiggy.net>; from wichert@wiggy.net on Wed, Aug 11, 2004 at 12:53:38PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 12:53:38PM +0200, Wichert Akkerman wrote:
> Previously Christoph Hellwig wrote:
> >  a) yo'ure not using the proper firmware loader but some horrible
> >     handcrafted code using sys_open/sys_read & co that's not namespace
> >     safe at all
> 
> It can use standard hotplug firmware load as well.

Okay, I'll take that back.

