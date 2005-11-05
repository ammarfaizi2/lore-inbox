Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVKEAie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVKEAie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVKEAie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:38:34 -0500
Received: from verein.lst.de ([213.95.11.210]:59048 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751384AbVKEAid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:38:33 -0500
Date: Sat, 5 Nov 2005 01:38:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] ppc64: 64K pages support
Message-ID: <20051105003819.GA11505@lst.de>
References: <1130915220.20136.14.camel@gaston> <1130916198.20136.17.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130916198.20136.17.camel@gaston>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So how does the 64k on 4k hardware emulation work?  When Hugh did
bigger softpagesize for x86 based on 2.4.x he had to fix drivers all
over to deal with that.
