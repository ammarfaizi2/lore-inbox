Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266000AbUA1SHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUA1SGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:06:23 -0500
Received: from gprs192-165.eurotel.cz ([160.218.192.165]:19331 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266000AbUA1SGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:06:11 -0500
Date: Wed, 28 Jan 2004 19:04:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040128180432.GB1344@elf.ucw.cz>
References: <20040127184029.GI32525@stop.crashing.org> <20040128165104.GC1200@elf.ucw.cz> <20040128170520.GI6577@stop.crashing.org> <20040128174402.GI340@elf.ucw.cz> <20040128175646.GJ6577@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128175646.GJ6577@stop.crashing.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Er, what's this against?  I don't have drivers/net/kgdb_eth.c in my repo
> > > right now (nor the -netpoll patch, but I'll happily take a patch to add
> > > the kgdb over enet stub and -netpoll).
> > 
> > It's against 2.6 + -netpoll + Amit's patch.
> 
> But doesn't -mm have a kgdb over enet driver that does work?  It's just
> not been ported to Amit's bits, right?

Yes.

I took kgdb-over-ethernet from -mm and made it compile with rest of
Amit's code.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
