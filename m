Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266411AbSKOQQt>; Fri, 15 Nov 2002 11:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266409AbSKOQQt>; Fri, 15 Nov 2002 11:16:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:56038 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266408AbSKOQQq>;
	Fri, 15 Nov 2002 11:16:46 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
To: Larry McVoy <lm@bitmover.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, mbligh@aracnet.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF13B0B9E1.574AFCAA-ON85256C72.00595C26@pok.ibm.com>
From: "Khoa Huynh" <khoa@us.ibm.com>
Date: Fri, 15 Nov 2002 10:23:19 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/15/2002 11:23:20 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This may or may not help but it seems relevant.  BK has uniq names for
>each changeset, we're fixing BK/Web so you can use the uniq names instead
>of the revs (which change out from under you).
>
>So it should be possible to link the bug report with a changeset in Linus'
>tree if you want.
>
>It's worth pointing out that if you can see the bug in a particular
version
>of Linus' tree then *everyone* can see it by getting a copy of the tree
>as of that cset.  BK guarentees that if you clone -r<rev> then you'll see
>exactly what anyone else saw as of that cset.

Yes, this is great!  We can create a separate field in the bug reports to
contain this unique names, so we can reference the cset directly from
the bug reports.  This allows us to link bug reports to csets -- great!

What format will these unique names be in?  If we put them in the bug
reports,
can we click on them (as URLs) and get to the csets directly?
Thanks.

Khoa


