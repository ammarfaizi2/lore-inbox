Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVDDV0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVDDV0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDDVYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:24:24 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:40077 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261416AbVDDVXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:23:01 -0400
X-ME-UUID: 20050404212243905.022F31800093@mwinf0801.wanadoo.fr
Date: Mon, 4 Apr 2005 23:19:31 +0200
To: "Theodore Ts'o" <tytso@mit.edu>, Sven Luther <sven.luther@wanadoo.fr>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404211931.GB3421@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050404205527.GB8619@thunk.org>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 04:55:27PM -0400, Theodore Ts'o wrote:
> On Mon, Apr 04, 2005 at 09:29:45PM +0200, Sven Luther wrote:
> > 
> > Nope, i am aiming to clarify this issue with regard to the debian kernel, so
> > that we may be clear with ourselves, and actually ship something which is not
> > of dubious legal standing, and that we could get sued over for GPL violation.
> > 
> 
> You know, the fact that Red Hat, SuSE, Ubuntu, and pretty much all
> other commercial distributions have not been worried about getting
> sued for this alleged GPL'ed violation makes it a lot harder for me
> (and others, I'm sure) take Debian's concerns seriously.

They probably didn't care :)

> The problem may be that because Debian is purely a non-profit, and so
> it can't clearly balance the costs and benefits of trying trying to
> avoid every single possible risks where someone might decide to file a
> lawsuit.  Anytime you do *anything* you risk the possibility of a
> lawsuit, and if you allow the laywers to take over your business
> decisions, the natural avoid-risks-all-costs bias of lawyers are such
> that it will either drive a company out of business, or drive a
> non-profit distribution into irrelevance.....

Yes, the problem is indeed that we don't have a legal department which can
counter sue, and we are present in a much more widespread area than other
companies you cited above.

And ubuntu has those driver in their non-free equivalent also.

> If Debian wants to be this fanatical, then let those Debian developers
> who care do all of the work to make this happen, and stop bothering
> LKML.  And if it continues to remain the case that a user will have to
> manually edit /etc/apt/sources.lists (using vi!) to include a
> reference to non-free in order to install Debian on a system that
> requires the tg3 device driver, then I will have to tell users who ask
> me that they would be better off using some other distribution which
> actually cares about their needs.

I don't get this, and you threat me as fanatic. I am only saying that the
tg3.c and other file are under the GPL, and that the firmware included in it
is *NOT* intented to be under the GPL, so why not say it explicitly ? 

Friendly,

Sven Luther

