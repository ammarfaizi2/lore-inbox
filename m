Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267732AbUBTDSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 22:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267735AbUBTDSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 22:18:42 -0500
Received: from dp.samba.org ([66.70.73.150]:52371 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267732AbUBTDSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 22:18:41 -0500
Date: Fri, 20 Feb 2004 14:17:51 +1100
From: Anton Blanchard <anton@samba.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paulmck@us.ibm.com, arjanv@redhat.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, torvalds@osdl.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040220031751.GA20022@krispykreme>
References: <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040218230055.A14889@infradead.org> <20040218153234.3956af3a.akpm@osdl.org> <20040219123237.B22406@infradead.org> <20040219105608.30d2c51e.akpm@osdl.org> <20040219190141.A26888@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219190141.A26888@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> You've probably not seen the AIX VM architecture.  Good for you as it's
> not good for your stomache.  I did when I still was SCAldera and although
> my NDAs don't allow me to go into details I can tell you that the AIX
> VM architecture is deeply tied into the segment architecture of the Power
> CPU and signicicantly different from any other UNIX variant.

Interesting, what version of AIX did you get access to? And how can you
be sure thats still the case?

Anton
