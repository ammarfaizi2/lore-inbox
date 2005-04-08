Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVDHEGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVDHEGC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVDHEGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:06:01 -0400
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:40409 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S262675AbVDHEFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:05:40 -0400
Date: Fri, 8 Apr 2005 00:05:27 -0400
From: Raul Miller <moth@debian.org>
To: linux-kernel@vger.kernel.org, debian-legal@lists.debian.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408000527.Z32136@links.magenta.com>
References: <87is2ydnmk.fsf@kreon.lan.henning.makholm.net> <MDEHLPKNGKAHNMBLJOLKIEAEDAAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEAEDAAB.davids@webmaster.com>; from davids@webmaster.com on Thu, Apr 07, 2005 at 08:05:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 08:05:31PM -0700, David Schwartz wrote:
>         I think we have a real problem, however, in cases where the source
> file that holds only the firmware data contains a GPL notice.

Sure: the GPL notice isn't completely valid.  But I think people have
already decided that this is an issue that needs to be fixed.  And,
I think most of the approach for fixing these is fairly clear.

That said... perhaps it's worth going over a hierarchy of copyright
issues:

First, there's the issue of whether or not work is protected by copyright.
I think we're talking about stuff that's protected by copyright.

If it is protected by copyright, there's the question of whether the
things being done with that work are regulated by copyright law.  I think
we're talking about activities (making copies of linux and distributing
it) which are regulated by copyright law.

If both hold, the next question is whether or not the copyright license
allows this use.  As you've indicated, we do have some real issues here.

Finally, if you're dealing with regulated activity and the license
doesn't allow it, it's up to the copyright holder to decide whether or
not to prosecute.  So far, the copyright holders haven't said much about
these issues.

We probably have some issues where what we're doing is only by the good
graces of the copyright holder(s).  We should fix those things, of course,
but currently there aren't any deadlines we have to meet.

-- 
Raul
