Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUHKTQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUHKTQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUHKTQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:16:58 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:45855 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268179AbUHKTQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:16:56 -0400
Date: Wed, 11 Aug 2004 21:19:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Building on platforms other than Linux
Message-ID: <20040811191908.GA7668@mars.ravnborg.org>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <20040811091349.GX862@cse.unsw.edu.au> <20040811185453.GA7217@mars.ravnborg.org> <1092250991.2816.21.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092250991.2816.21.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 09:03:11PM +0200, Arjan van de Ven wrote:
> 
> > [I recall Red Hat already disables the shared library??]
> 
> we don't do no such thing, sir. :-)

OK.

It was the following patch that I recalled seeing:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108599543602571&w=2

One day I may land a non-interactive frontend for kconfig, so
we can have this functionality added in the kernel proper.

	Sam
