Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTJCX10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTJCX10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:27:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:21158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261396AbTJCX1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:27:24 -0400
Date: Fri, 3 Oct 2003 16:18:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: must-fix list reconciliation
Message-Id: <20031003161855.3c20f2b5.rddunlap@osdl.org>
In-Reply-To: <3F7E03E3.1090005@cyberone.com.au>
References: <3F7D3F37.1060005@cyberone.com.au>
	<20031003113437.GL24824@parcelfarce.linux.theplanet.co.uk>
	<20031003083640.61dcf517.rddunlap@osdl.org>
	<3F7DFE52.9010400@cyberone.com.au>
	<20031003160224.6737b593.rddunlap@osdl.org>
	<3F7E03E3.1090005@cyberone.com.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Oct 2003 09:18:59 +1000 Nick Piggin <piggin@cyberone.com.au> wrote:

| 
| 
| Randy.Dunlap wrote:
| 
| >On Sat, 04 Oct 2003 08:55:14 +1000 Nick Piggin <piggin@cyberone.com.au> wrote:
| >
| >
| snip
| 
| >| 
| >| To be honest I don't really like the wiki. I'd rather changes go through
| >| lkml where its easier to discuss them and keep up with them. Thats just my
| >| preference though. I don't know what anyone else thinks.
| >
| >I don't quite see how they belong in the kernel source tree,
| >although I don't mind...  That's not where I would expect to find
| >the list, though.  I would expect it more on kernel.org e.g.
| >
| 
| I don't know what the criteria is. It would help lazy people send 
| patches. If
| its in the tree they might, if they have to check if they've got the newest
| version and download it from somewhere else, they won't.
| 
| I was thinking it could become a criteria (obviously with exceptions) for
| feature / code freezes. I don't know what Linus or Andrew or anyone else 
| think about this though.
| 
| 
| snip
| 
| >
| >| 
| >| Yes, and even easier if there was just one editor.
| >| eg. there 2 drivers/acpi sections in the mustfix list on wiki.
| >
| >One editor if it's in a "file" vs. being in a wiki.
| >
| 
| Well if its on the wiki you still need a janitor at least. The shouldfix 
| list
| there is beginning to look like peoples' personal todo lists.
| 
| >
| >| I'd like to keep the 2 lists seperate. The must-fix list is concise and easy
| >| to scan the whole thing. I guess this isn't a problem if there is one 
| >| editor.
| >| 
| >
| snip
| 
| >| 
| >| If it ends up going into a source tree, I can be the editor / maintainer.
| >
| >of only must-fix and not should-fix??
| >I wouldn't want to see should-fix abandoned.
| >
| 
| No, both

OK, I don't really care where it is.
If you are willing to keep it updated, you get to choose where
it lives (IMO).

--
~Randy
