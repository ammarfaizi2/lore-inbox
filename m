Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUHNLHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUHNLHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUHNLHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:07:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:19942 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266453AbUHNLGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:06:11 -0400
Date: Sat, 14 Aug 2004 04:05:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
In-Reply-To: <20040814115548.A19527@infradead.org>
Message-ID: <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
 <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Aug 2004, Christoph Hellwig wrote:
> 
> Cane we make this 2.6.9 to avoid breaking all kinds of scripts expecting
> three-digit kernel versions?

Well, we've been discussing the 2.6.x.y format for a while, so I see this 
as an opportunity to actually do it... Will it break automated scripts? 
Maybe. But on the other hand, we'll never even find out unless we try it 
some time.

		Linus
