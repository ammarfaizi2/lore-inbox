Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265312AbUFSAlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265312AbUFSAlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUFRUkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:40:35 -0400
Received: from [195.255.196.126] ([195.255.196.126]:35542 "EHLO
	gw.compusonic.fi") by vger.kernel.org with ESMTP id S261880AbUFRUba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:31:30 -0400
Date: Fri, 18 Jun 2004 23:31:28 +0300 (EEST)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: 4Front Technologies <dev@opensound.com>,
       Timothy Miller <miller@techsource.com>,
       Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <F1B17570-C158-11D8-9A43-000393ACC76E@mac.com>
Message-ID: <Pine.LNX.4.58.0406182301060.20412@zeus.compusonic.fi>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
 <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de>
 <40D32C1D.80309@opensound.com> <40D33464.6030403@techsource.com>
 <40D33338.6050001@opensound.com> <F1B17570-C158-11D8-9A43-000393ACC76E@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Kyle Moffett wrote:

> On Jun 18, 2004, at 14:23, 4Front Technologies wrote:
> > Timothy,
> >
> > Who are you to revoke my request to SuSE and other distributors and
> > others who share
> > my views on LKML?
>
> Who are you to demand it in the first place.  As far as I can see,
> you've contributed
> nothing notable to the kernel development community (But please correct
> me if I'm
> wrong).
A minor correction. We have not contributed much recently (if not counting
few minor patches that have been rejected). However the oldest layers
(until 1996/1997) of the kernel OSS drivers are mostly our work.

> you've done is demand things of the LKML, but why should we listen to
> your demands instead of our own.
It depends on if you are developing just for yourself and few of your
friends. However if you like your work being used by majority of computer
users then it would be a good idea to listen all kind of input. Even
input you don't like to hear.

> > What is wrong with making a demand for standardization?. It's high time
> > that things got a bit more organized. And where do you see a
> > demand....I just
> > said "like to see". Which is more of a request the way I understand
> > English.
>
> If you want things more organized, then please code it up and submit a
> series of
> clean patches against the current kernel.
We will do that in the near future.

> Besides, a lack of
> organization is
> sometimes a good thing. (See _The_Cathedral_and_the_Bazaar_:
> <http://www.catb.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/>).
Lack of organization is good thing in the right place. However lack of
standardization in a wrong place is not good. For example the ls command
cannot be renamed to "dir", "stat", "list-files" or anything else.

Equally well it's going to be usefull to have a standardized command (say
/lib/modules/`uname -r`/build/scripts/kbuild /my/source/directory) rather
than having different make commands required by each Linux distribution.
Nothing prevents the distribution maintainers from optimizing that command
in a way they like as long as the usage remains the same.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
