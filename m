Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbUJ0Cc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUJ0Cc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUJ0CcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:32:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:25546 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261572AbUJ0Cax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:30:53 -0400
Date: Wed, 27 Oct 2004 04:30:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041026010141.GA15919@work.bitmover.com>
Message-ID: <Pine.LNX.4.61.0410270338310.877@scrub.home>
References: <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com>
 <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random>
 <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
 <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Oct 2004, Larry McVoy wrote:

> You are mistakenly assuming that the way BK stores the data, or does
> merges, or synchronizes is what we think is worth protecting, and you
> are pretty much wrong.

Does that mean you don't mind if someones export the changeset information 
in an useful way? All I need is pretty much the information that already 
comes via the commit list (actually in the format used until May, where 
it still contained information about renames) plus some useful identifiers 
to identify the predecessors of a changeset.

bye, Roman
