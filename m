Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbSKEEIV>; Mon, 4 Nov 2002 23:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbSKEEIV>; Mon, 4 Nov 2002 23:08:21 -0500
Received: from ns.suse.de ([213.95.15.193]:41736 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266228AbSKEEIT> convert rfc822-to-8bit;
	Mon, 4 Nov 2002 23:08:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Tue, 5 Nov 2002 05:14:53 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, davej@suse.de
References: <20021101085148.E105A2C06A@lists.samba.org> <1036175565.2260.20.camel@mentor>
In-Reply-To: <1036175565.2260.20.camel@mentor>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211050514.53709.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 19:32, Dax Kelson wrote:
> On Fri, 2002-11-01 at 01:49, Rusty Russell wrote:
> > I'm down to 8 undecided features: 6 removed and one I missed earlier.
>
> How about Olaf Dietsche's filesystem capabilities support? It has been
> posted a couple times to LK, yesterday even.
>
>
> We've had capabilities for ages (2.2?) but no filesystem support.
>
> OpenBSD is recently bragging about no longer having any SUID root
> binaries on the system.
>
> With FS capabilities we (Linux) can have the same situation.  Security
> is a hot topic, and anything the kernel can do make security
> better/easier seems worthy of consideration.

We have little experience with full blown capability enabled systems. Rushing 
things doesn't seem like a good idea. IMO we should wait until vendors have 
integrated FS caps before adding this to the standard kernel.

--Andreas.
