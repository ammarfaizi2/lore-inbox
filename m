Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbUB0Mev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUB0Mei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:34:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:51898 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262743AbUB0Mbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:31:33 -0500
Subject: Re: [PATCH] ppc64 iommu rewrite part 2/5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040227122849.A31898@infradead.org>
References: <1077883862.22213.365.camel@gaston>
	 <20040227122849.A31898@infradead.org>
Content-Type: text/plain
Message-Id: <1077884554.22925.382.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 23:22:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Umm, can't we plaese define a hook in all pors and use it here instead
> of one hack per port?

I'm adding that to my todo-list ;) I'm too tired to do it tonight
and I'm not sure I want to do anything that productive this
week-end ;)

(That whole iommu stuff ended up beeing more painful to get right
than I expected at first, but I'm happy we have that less crap in
arch/ppc64 now)

Ben.


