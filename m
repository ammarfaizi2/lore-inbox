Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUFSA0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUFSA0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUFSAWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:22:55 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:41020 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263301AbUFRUrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:47:46 -0400
Date: Fri, 18 Jun 2004 22:58:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Tom Rini <trini@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040618205815.GD4441@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
References: <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org> <20040615204616.E7666@flint.arm.linux.org.uk> <20040615205557.GK2310@mars.ravnborg.org> <20040615220646.I7666@flint.arm.linux.org.uk> <20040616194919.GA4384@mars.ravnborg.org> <20040616200824.GF24479@smtp.west.cox.net> <20040616205415.GA2096@mars.ravnborg.org> <20040617065624.GB20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617065624.GB20632@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 08:56:24AM +0200, Jan-Benedict Glaw wrote:
> On Wed, 2004-06-16 22:54:16 +0200, Sam Ravnborg <sam@ravnborg.org>
> wrote in message <20040616205415.GA2096@mars.ravnborg.org>:
> > On Wed, Jun 16, 2004 at 01:08:24PM -0700, Tom Rini wrote:
> > > Will it also include the 'vmlinux' ?
> > Today the rpm does not include vmlinux - but thats a trivial thing to add.
> > I assume the same is tru for .deb
> > tar.gz is not written yet...
> 
> I'll take your patches and see how to make a .tar.gz from it.

Great, thanks.
I will update my patch-set during the weekend if time permits..

	Sam
