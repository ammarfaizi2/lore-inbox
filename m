Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbULBSOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbULBSOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbULBSLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:11:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:29078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261702AbULBSKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:10:53 -0500
Date: Thu, 2 Dec 2004 10:10:29 -0800
From: cliff white <cliffw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mbligh@aracnet.com, akpm@osdl.org, torvalds@osdl.org, clameter@sgi.com,
       hugh@veritas.com, benh@kernel.crashing.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041202101029.7fe8b303.cliffw@osdl.org>
In-Reply-To: <41AEC4D7.4060507@pobox.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	<41AEB44D.2040805@pobox.com>
	<20041201223441.3820fbc0.akpm@osdl.org>
	<41AEBAB9.3050705@pobox.com>
	<20041201230217.1d2071a8.akpm@osdl.org>
	<179540000.1101972418@[10.10.2.4]>
	<41AEC4D7.4060507@pobox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2004 02:31:35 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Martin J. Bligh wrote:
> > Yeah, probably. Though the stress tests catch a lot more than the 
> > functionality ones. The big pain in the ass is drivers, because I don't
> > have a hope in hell of testing more than 1% of them.
> 
> My dream is that hardware vendors rotate their current machines through 
> a test shop :)  It would be nice to make sure that the popular drivers 
> get daily test coverage.
> 
> 	Jeff, dreaming on

OSDL has recently re-done the donation policy, and we're much better positioned
to support that sort of thing now - Contact Tom Hanrahan at OSDL if you 
are a vendor, or know a vendor. ( Or you can become a vendor ) 

cliffw

> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
