Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVDDVCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVDDVCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVDDU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:59:47 -0400
Received: from thunk.org ([69.25.196.29]:23438 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261400AbVDDUzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:55:38 -0400
Date: Mon, 4 Apr 2005 16:55:27 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404205527.GB8619@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Sven Luther <sven.luther@wanadoo.fr>, Greg KH <greg@kroah.com>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404192945.GB1829@pegasos>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 09:29:45PM +0200, Sven Luther wrote:
> 
> Nope, i am aiming to clarify this issue with regard to the debian kernel, so
> that we may be clear with ourselves, and actually ship something which is not
> of dubious legal standing, and that we could get sued over for GPL violation.
> 

You know, the fact that Red Hat, SuSE, Ubuntu, and pretty much all
other commercial distributions have not been worried about getting
sued for this alleged GPL'ed violation makes it a lot harder for me
(and others, I'm sure) take Debian's concerns seriously.

The problem may be that because Debian is purely a non-profit, and so
it can't clearly balance the costs and benefits of trying trying to
avoid every single possible risks where someone might decide to file a
lawsuit.  Anytime you do *anything* you risk the possibility of a
lawsuit, and if you allow the laywers to take over your business
decisions, the natural avoid-risks-all-costs bias of lawyers are such
that it will either drive a company out of business, or drive a
non-profit distribution into irrelevance.....

If Debian wants to be this fanatical, then let those Debian developers
who care do all of the work to make this happen, and stop bothering
LKML.  And if it continues to remain the case that a user will have to
manually edit /etc/apt/sources.lists (using vi!) to include a
reference to non-free in order to install Debian on a system that
requires the tg3 device driver, then I will have to tell users who ask
me that they would be better off using some other distribution which
actually cares about their needs.

						- Ted
