Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVDDR4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVDDR4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVDDRyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:54:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:50596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261314AbVDDRvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:51:50 -0400
Date: Mon, 4 Apr 2005 10:51:30 -0700
From: Greg KH <greg@kroah.com>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404175130.GA11257@kroah.com>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404141647.GA28649@pegasos>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 04:16:47PM +0200, Sven Luther wrote:
> This is just the followup on said discussion, involving the larger LKML
> audience, in order to get this fixed for good. As said, it is just a mere
> technicality to get out of the muddy situation, all the people having
> contributed source-less firmware blobs, need to give us (us being debian, but
> also all the linux kernel community) either the source if they persist in
> distributing the code under the GPL, or a clear distribution licence for these
> firmware blobs, and clearly identificate them as not covered by the GPL that
> the file they come in is.

What if we don't want to do so?  I know I personally posted a solution
for this _5_ years ago in debian-legal, and have yet to receive a
patch...

> Discussing legal issues is all cool and nice for those that appreciates such
> sport, but it doesn't really make sense if it is not applied to acts later on.

Then let's see some acts.  We (lkml) are not the ones with the percieved
problem, or the ones discussing it.

bleah.

greg k-h
