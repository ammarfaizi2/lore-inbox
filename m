Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbUCZN0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 08:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUCZN0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 08:26:08 -0500
Received: from ns.suse.de ([195.135.220.2]:26029 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264047AbUCZN0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 08:26:06 -0500
Subject: Re: [PATCH] lockfs patch for 2.6
From: Chris Mason <mason@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040326102549.A4248@infradead.org>
References: <1078867885.25075.1458.camel@watt.suse.com>
	 <20040313131447.A25900@infradead.org>
	 <1079191213.4187.243.camel@watt.suse.com>
	 <20040313163346.A27004@infradead.org> <20040314140032.A8901@infradead.org>
	 <1079277810.4183.249.camel@watt.suse.com>
	 <20040326102549.A4248@infradead.org>
Content-Type: text/plain
Message-Id: <1080307694.2820.81.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 08:28:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 05:25, Christoph Hellwig wrote:
> On Sun, Mar 14, 2004 at 10:23:31AM -0500, Chris Mason wrote:
> > > P.S. this patch now kills 16 lines of kernel code summarized :)
> > > 
> > 
> > It looks good, I'll give it a try.
> 
> ping?  I've seen you merged the old patch into the suse tree, and having
> shipping distros with incompatible APIs doesn't sound exactly like a good
> idea..

I'm replacing the old one in the suse tree, I just got sucked into to a
few critical tasks.  Yours is the way to go.

-chris


