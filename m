Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265091AbSJWQRC>; Wed, 23 Oct 2002 12:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265089AbSJWQRC>; Wed, 23 Oct 2002 12:17:02 -0400
Received: from user19.okena.com ([65.196.32.19]:27767 "EHLO
	gatemaster.okena.com") by vger.kernel.org with ESMTP
	id <S265088AbSJWQRB>; Wed, 23 Oct 2002 12:17:01 -0400
From: Slavcho Nikolov <snikolov@okena.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-ID: <008b01c27ab0$760be900$800a140a@SLNW2K>
References: <20021023003959.GA23155@bougret.hpl.hp.com> <004c01c27a99$927b8a30$800a140a@SLNW2K> <3DB6AC40.20007@nortelnetworks.com>
Subject: over&out (Re: feature request - why not make netif_rx() a pointer?)
Date: Wed, 23 Oct 2002 12:23:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote
| I don't think you understand the nature of the GPL and linux development.

What a presumptuous opening statement!

| The kernel developers do not have any obligation to anything other than
| technical excellence.  You're getting a highly optimized operating
| system *at no financial cost*.  In return, the community requires that
| certain types of modifications be made publicly available.

Yes, many companies from time to time feed smaller or larger contributions
back into the community.
But they don't usually release *all* their modifications because they just
might be irrelevant to everyone but a small niche of enterprise users.

| If you want to replace the messaging code, make a GPL'd kernel patch and
| make it available to your clients (of course they can then publish it
| all over the place if they so desire).  If those terms are not
| acceptable, there's always BSD.

It doesn't quite work that way. Big name distributors (e.g. Suse, Redhat)
usually supply
and support big customers with Linux distributions. Third parties usually
supply modules.
Integration of the two is demanded by the customer, so it's not our choice
to
use BSD or ask the end users that our patches be applied and their kernels
recompiled.
Certainly patches can be rolled out but it's a costly proposition
(especially to customers)
and requires a level of expertise and commitment on the part of the
customers that
may not be available.

Nearly every storage or networking startup that uses Linux (hundreds of them
exist)
has tried to find hooks into the filesystems or network stacks, within the
constraints
of  modules and GPL. It isn't always easy to insert oneself where we want
but they have found interesting solutions and work-arounds whether or not on
the
legal grounds are shaky.
All I said was that it's good to make life easier for these startups.
S.N.

