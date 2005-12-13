Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVLMMdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVLMMdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 07:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVLMMdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 07:33:20 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:5250 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750829AbVLMMdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 07:33:19 -0500
Date: Tue, 13 Dec 2005 05:33:18 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213123318.GH9286@parisc-linux.org>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213090517.GQ23384@wotan.suse.de> <20051213011540.3070176f.akpm@osdl.org> <20051213092437.GS23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213092437.GS23384@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 10:24:37AM +0100, Andi Kleen wrote:
> > Spose so - I don't know what people are using out there.
> 
> I don't think it was shipped in major distros at least (AFAIK) 
> They all went from 2.95 to 3.1/3.2 

Debian Woody (3.0) shipped a mess of compilers -- 2.95 for most, 2.96
for ia64 and 3.0 for parisc.  That was released in July 2002.  Sarge
(3.1) shipped in June 2005 and uses GCC 3.3 on all architectures.

