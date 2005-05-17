Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVEQRpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVEQRpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEQRpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:45:33 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:16910 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261937AbVEQRob
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:44:31 -0400
Date: Tue, 17 May 2005 18:44:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
In-Reply-To: <Pine.LNX.4.58.0505171017480.18337@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61L.0505171839490.17529@blysk.ds.pg.gda.pl>
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay>
 <42899797.2090702@sw.ru> <Pine.LNX.4.58.0505170844550.18337@ppc970.osdl.org>
 <Pine.LNX.4.61L.0505171656300.17529@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0505170928220.18337@ppc970.osdl.org>
 <Pine.LNX.4.61L.0505171747540.17529@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0505171017480.18337@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Linus Torvalds wrote:

> IOW, testing is good, but it's _not_ good if you test your users to 
> destruction.  User testing should be limited (as far as humanly possible) 
> to things that they can sanely report.

 Oh, absolutely.  I do agree -- I've just wanted to point out the 
advantages and drawbacks of the watchdog in case someone (not necessarily 
you) misses them. ;-)

  Maciej
