Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTF0PGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTF0PFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:05:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:35714 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264544AbTF0PCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:02:43 -0400
Date: Fri, 27 Jun 2003 16:25:05 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306271525.h5RFP5K1001776@81-2-122-30.bradfords.org.uk>
To: davem@redhat.com, matti.aarnio@zmailer.org, mbligh@aracnet.com
Subject: Re: networking bugs and bugme.osdl.org
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ok, responding so that the response appears also
> > at the bug db is another story.
>
> That is possible to do - there's patches to Bugzilla that implement an
> email interface, but it has some problems like the one you pointed out
> above. One possiblility is to make people manually do something to the
> email for each reply, but that's rather ugly. 
>
> Hopefully we can discuss this more at OLS this year, and get a plan 
> going forward that people are happy with. I'm well aware that Bugzilla
> is not the perefect tool, but I think it's better than what we had 
> before (yeah, I know some of us disagree), and is easy to change.
> I'd rather start with something simple, and evolve it to the needs of
> the community than try dumping something complex onto people up front.

I did make the effort to make a dedicated bug database for kernel
development in December last year.  Do people actively hate it, or are
they just not aware of it?  :-).  I got some very favourable comments
early on, and a review in a Linux magazine, but haven't had much
feedback recently about it.  I was specifically trying to address the
kind of problems we're seeing with Bugzilla...

http://grabjohn.com/kernelbugdatabase

John.
