Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSJVBCc>; Mon, 21 Oct 2002 21:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSJVBCc>; Mon, 21 Oct 2002 21:02:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261856AbSJVBCb>;
	Mon, 21 Oct 2002 21:02:31 -0400
Message-ID: <3DB4A51E.3040405@pobox.com>
Date: Mon, 21 Oct 2002 21:08:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Yay, bug tracking! (was Re: Bug tracking in the run up from 2.5 to
 2.6)
References: <205680000.1034895125@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> We're proposing to create a bug tracking system to help keep track of
> 2.5 kernel bugs ... in an attempt to help get 2.5 stabilised as quickly as
> possible. 

> It would be based on Bugzilla, and open for anyone to log bugs against
> 2.5, though those would then be filtered by a set of "maintainers" to keep
> the quality of the data up to snuff. Ideally those would be the subsystem
> maintainers as we know them now, though in the event that certain people
> weren't interested, we'd find a "bugzilla maintainer" for the subsystem to
> fill that role.

This is fantastic.

This is one of the things I think the Linux kernel sorely lacks, both 
image-wise and practically-speaking.  Ted T'so maintained a bug list for 
a while, and it was (a) valuable and (b) way too much work for one human 
to possibly handle.


> IBM's Linux Technology Centre is willing to provide the machine, admin, 
> and people to help maintain the data in the database. We have someone
> who's kindly agreed in principle to host the machine for us (feel free to 
> speak up if you like, otherwise I'll wait until the proposal is firmed up).

Again, fantastic.  As was discussed at the original Kernel Summit (and 
perhaps the latest one as well?), everyone knows we need a bug tracking 
system, but without humans to help keep the garbage bug reports to a 
minimum, the system won't be used by developers _or_ users with 
legitimate problems.


> We'll also have a slew of engineers dedicated to stabilise 2.5 after the
> freeze, but this is not intended to be solely an IBM thing by any means;
> we're volunteering to host the tracking database on behalf of the community,
> and do some of the dirty work of administration. The intent is to have this
> up and running by Halloween, and for a signification cross-section of the 
> community to use it.
> 
> So ... are the maintainers interested in working with this kind of system?

I certainly am.  Even though I claim to be net driver maintainer, I 
don't begin to claim that I can track and fix _all_ bugs in _all_ net 
drivers, even though I endeavor to do the best I can.

This Bugzilla system, I believe, should help a great deal.

I'm definitely willing to give it an honest shot with net drivers, and I 
hope that we can persuade others to do so as well.

One suggestion - it might be nice for IBM to register "linuxbugs.org" or 
bugzilla.kernel.org or similar, so to provide an additional impression 
of impartiality.  I don't mind "Hosted by IBM!" plastered all over the 
site, but if Bugzilla ever needs to move, that makes things much easier.

	Jeff



