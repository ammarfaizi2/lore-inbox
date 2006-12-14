Return-Path: <linux-kernel-owner+w=401wt.eu-S932813AbWLNPkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbWLNPkN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbWLNPkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:40:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36280 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932811AbWLNPkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:40:11 -0500
Date: Thu, 14 Dec 2006 15:47:34 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Rik van Riel <riel@redhat.com>
Cc: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
Message-ID: <20061214154734.189a23c6@localhost.localdomain>
In-Reply-To: <4581595C.7080508@redhat.com>
References: <20061214003246.GA12162@suse.de>
	<22299.1166057009@lwn.net>
	<20061214005532.GA12790@suse.de>
	<20061214051015.GA3506@nostromo.devel.redhat.com>
	<20061214084820.GA29311@suse.de>
	<4581595C.7080508@redhat.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pretty much every license under the sun is getting violated,
> and people are getting away with it. The GPL is not special
> in this regard.

That may begin to change in time. There are a lot of people getting very
angry at the political level about the way large companies in particular
flout copyright law and claim to "not know" because they just bought
something in, often from Taiwan or China, with stolen code in it.

There are proposals on the table in the EU to make commercial piracy a
criminal not a civil matter in the case of copyright. (The original
proposal also suggested for patents which would have been rather dumb but
that seems to have been killed off for now). So in a couple years a GPL
violating product in the EU may entail a walk down to the local police
station rather than a private court case. 

In the UK also trading standards whose remit right now is trademark abuse
will also be getting enforcement powers and funding for copyright stuff.
The powers that be are mostly thinking "pirate DVD in the local market
stall", but some of us have other ideas.

We do need to distinguish between the blatant violators and the
borderline people - there's a difference between the folks shipping Linux
rip-offs binary only in random unlabelled routers and people like Nvidia
and Novell who are on the edge of the license corner cases.

Another thing we should do more is aggressively merge prototype open
drivers for binary only hardware - lets get Nouveau's DRM bits into the
kernel ASAP for example.

Alan
