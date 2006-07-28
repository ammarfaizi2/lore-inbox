Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161389AbWG1Xu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161389AbWG1Xu5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161390AbWG1Xu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:50:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:38320 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161389AbWG1Xu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:50:56 -0400
Date: Fri, 28 Jul 2006 16:26:54 -0700
From: Greg KH <greg@kroah.com>
To: Nathan Scott <nathans@sgi.com>, stable@kernel.org,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.17.[1-6] XFS Filesystem Corruption, Where is 2.6.17.7?
Message-ID: <20060728232654.GB2140@kroah.com>
References: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan> <20060725084624.C2090627@wobbly.melbourne.sgi.com> <20060725210716.GC4807@merlin.emma.line.org> <20060725210919.GD4807@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725210919.GD4807@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 11:09:19PM +0200, Matthias Andree wrote:
> On Tue, 25 Jul 2006, Matthias Andree wrote:
> 
> > A serious suggestion is, providing that the arguments presented (people
> > busy with OLS preparations and long review queue for 2.6.17.N+1):
> > 
> > How about doing 2.6.17.7 as an interim release fixing just what is known
> > to be critical at the point of the release, and then review the rest for
> > 2.6.17.8? That would nicely fit the release early, release often - users
> > like that particularly for bug fixes.
> 
> OK, 2.6.17.7 is out, but still - is this suggestion worthwhile
> considering for future -stable release engineering or just crap?

.7 took a bit longer than expected, due to some security bugs that
needed to be added to the queue, combined with the fact that both Chris
and I were busy with OLS stuff.  Normally we both aren't travelling at
the same time, but right then, we were, so we couldn't respond as
quickly as it seems some people felt we should have.

Sorry about this, we'll try to do better next time.

greg k-h
