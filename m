Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268023AbUHKKxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268023AbUHKKxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUHKKxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:53:47 -0400
Received: from levante.wiggy.net ([195.85.225.139]:8321 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S268023AbUHKKxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:53:46 -0400
Date: Wed, 11 Aug 2004 12:53:38 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Christoph Hellwig <hch@infradead.org>,
       James Ketrenos <jketreno@linux.intel.com>, Pavel Machek <pavel@suse.cz>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040811105337.GC32420@wiggy.net>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Ketrenos <jketreno@linux.intel.com>,
	Pavel Machek <pavel@suse.cz>,
	Jeff Chua <jeffchua@silk.corp.fedex.com>,
	Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com> <20040714115523.GC2269@elf.ucw.cz> <20040809201556.GB9677@louise.pinerecords.com> <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com> <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz> <4119F203.1070009@linux.intel.com> <20040811114437.A27439@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811114437.A27439@infradead.org>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Christoph Hellwig wrote:
>  a) yo'ure not using the proper firmware loader but some horrible
>     handcrafted code using sys_open/sys_read & co that's not namespace
>     safe at all

It can use standard hotplug firmware load as well.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
