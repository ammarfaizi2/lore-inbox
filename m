Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUFWPDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUFWPDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUFWPDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:03:33 -0400
Received: from [213.146.154.40] ([213.146.154.40]:1432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266250AbUFWPDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:03:15 -0400
Date: Wed, 23 Jun 2004 16:03:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Timothy Miller <miller@techsource.com>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040623150314.GA24169@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Timothy Miller <miller@techsource.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>
References: <A095D7F069C@vcnet.vc.cvut.cz> <20040622151236.GE20632@lug-owl.de> <20040622173215.GA6300@infradead.org> <20040622184220.GF20632@lug-owl.de> <40D99A93.8030900@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D99A93.8030900@techsource.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 10:58:27AM -0400, Timothy Miller wrote:
> Whatever it is that VMware needs in the kernel can probably be 
> generalized in some way that makes it useful to other things (like 
> Win4Lin) and then merged into mainline.

We already have drivers/net/tun.c thaqt works nicely with Hercules and MoL
for me, but I guess the vmware folks want some additional deep magic.
