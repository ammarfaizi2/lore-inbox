Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266701AbSKOVFC>; Fri, 15 Nov 2002 16:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266721AbSKOVFC>; Fri, 15 Nov 2002 16:05:02 -0500
Received: from rth.ninka.net ([216.101.162.244]:34967 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S266701AbSKOVFB>;
	Fri, 15 Nov 2002 16:05:01 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
From: "David S. Miller" <davem@redhat.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <396026666.1037298946@[10.10.2.3]>
References: <1037325839.13735.4.camel@rth.ninka.net> 
	<396026666.1037298946@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 13:30:35 -0800
Message-Id: <1037395835.22209.3.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-14 at 18:35, Martin J. Bligh wrote:
> Hmmm ... I'm not sure that being that restrictive is going to help.

Yes it is unless you create toplevel categories for bugs that
are occuring on non-official kernel trees.

My expeience so far with this bug database has been that I just
immediately close every bug assigned to me, here are two
examples:

1) TCP crash with -mm2 patches --> known error in Andrew's
   patches

2) tcp_MSS doesn't compile --> already fixed in current BK tree

the list goes on and on, and the simple fact of the matter is that
I have yet to see a _REAL_ bonified bug.  If this is how this bug
database is going to continue to be used by people, it's going to
be of only limited usefullness to me.

Look, if #1 and #2 would have been posted to linux-kernel instead,
the fact is that before I woke up and hit my email box SOMEONE ELSE
would have responded and even sent that person a patch.

In this sense it appears that linux-kernel is more effective than
thus bug database, ESPECIALLY if we are going to allow people to
report bugs against trees with random patches applied.

