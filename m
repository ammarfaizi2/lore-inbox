Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVCDJQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVCDJQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVCDJQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:16:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10128 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262694AbVCDJQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:16:21 -0500
Date: Fri, 4 Mar 2005 10:16:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304091612.GG14764@suse.de>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com> <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random> <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org> <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de> <20050304005450.05a2bd0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304005450.05a2bd0c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04 2005, Andrew Morton wrote:
> The average user has learnt "rc1 == pre1".  I don't expect that it
> matters much at all.

The average user and lkml reader, perhaps. But I don't understand
why Linus refuses to use proper -preX/-rcX naming, it would
clear up a lot of confusion imho. It's just the logical thing
to do, Marcelo gets it completely right. That -rcX and -rcX+1
differ in what they mean is really confusing and opposite of
basically anything else out there.

With the 2.6.x-release tree and proper -pre/-rc naming, I would
be perfectly happy :-)

-- 
Jens Axboe

