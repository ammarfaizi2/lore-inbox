Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVDLXtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVDLXtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVDLXqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:46:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:24474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262977AbVDLXnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:43:19 -0400
Date: Tue, 12 Apr 2005 16:45:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: David Eger <eger@havoc.gtf.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
In-Reply-To: <20050412234005.GJ1521@opteron.random>
Message-ID: <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org>
 <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org>
 <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <20050412234005.GJ1521@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Apr 2005, Andrea Arcangeli wrote:
> 
> At the rate of 9M for every 198 changeset checkins, that means I'll have
> to download 2.7G _uncompressible_ (i.e. already compressed with a bad
> per-file ratio due the too-small files) for a whole pack including all
> changesets without accounting the original 111MB of the original tree,
> with rsync -z of git.  That compares with 514M _compressible_ with CVS
> format on-disk, and with ~79M of the CVS-network download with rsync -z of
> the CVS repository (assuming default gzip compression level).

Yes. CVS is much denser.

CVS is also total crap. So your point is?

		Linus
