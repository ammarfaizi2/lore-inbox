Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTFKR07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFKR07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:26:59 -0400
Received: from grieg.holmsjoen.com ([206.124.139.154]:49932 "EHLO
	grieg.holmsjoen.com") by vger.kernel.org with ESMTP id S262192AbTFKR05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:26:57 -0400
Date: Wed, 11 Jun 2003 10:39:36 -0700
From: Randolph Bentson <bentson@holmsjoen.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030611103936.A29520@grieg.holmsjoen.com>
References: <20030609213321.GP16164@fs.tum.de> <MDEHLPKNGKAHNMBLJOLKCEMCDIAA.davids@webmaster.com> <20030609222141.GS16164@fs.tum.de> <20030610131730.A26932@grieg.holmsjoen.com> <20030611153845.GA16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030611153845.GA16164@fs.tum.de>; from bunk@fs.tum.de on Wed, Jun 11, 2003 at 05:38:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 05:38:45PM +0200, Adrian Bunk wrote:
> You definitely don't need physical possession of the written offer.
> Otherwise 3c wouldn't work.

You cannot mix the terms of clauses 3a, 3b, and 3c.  The "written
offer" is only an element of clause 3b.

A significant point which seems to be glossed over is that the
distributor is the entity which selects which of these clauses,
3a, 3b, or 3c, is to be exercised to satisfy the GPL.  Each places
a different obligation on the distributor.

If the distributor elects to distribute the object code or executable
form under clause 3a, the distributor need only distribute copies of
the source to the recipients of the object code or executable form.

If the distributor elects to distribute the object code or executable
form under clause 3b, one might reasonably argue that the distributor
need only distribute the source to those third parties in possession
of the written offer which must be included.  Others may argue that
this clause requires that the distributor make the source available
to everyone, but even then the distributor is not obliged to put it
on the web and the distributor may charge for the distribution cost.

If the distributor elects to distribute the object code or executable
form under clause 3c, and is qualified to do so, the distributor
need only distribute the information to those who receive the object
code or executable form.  The distributor is not obliged to give
this information to everyone.

Of course, once anyone has a copy of this source, it may be further
distributed under sections 1, 2, or 3.


I'd like to see Linksys elect to distribute under clause 3b by putting
a note in each box with a pointer to source files which everyone
can fetch from their web site.  (I believe that web based distribution
qualifies as "a medium customarily used for software interchange"
cited in 3b and that they can simply absorb the cost of this method
of distribution.)  Recent news suggests that this will be the case.
Let's hope that they, and other such distributors of embedded GPL
based systems, follow this course.

--
Randolph Bentson
bentson@holmsjoen.com
