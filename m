Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262435AbSIZLYR>; Thu, 26 Sep 2002 07:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbSIZLYR>; Thu, 26 Sep 2002 07:24:17 -0400
Received: from mons.uio.no ([129.240.130.14]:60631 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262435AbSIZLYQ>;
	Thu, 26 Sep 2002 07:24:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15762.61332.832333.272997@charged.uio.no>
Date: Thu, 26 Sep 2002 13:29:24 +0200
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [BUG] NFS in 2.4.20-pre6+ stalls
In-Reply-To: <200209251530.g8PFUeI13628@vindaloo.ras.ucalgary.ca>
References: <200209251441.37444.trond.myklebust@fys.uio.no>
	<200209251530.g8PFUeI13628@vindaloo.ras.ucalgary.ca>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard Gooch <rgooch@ras.ucalgary.ca> writes:

     > Monday afternoon (my time) I grabbed the current BK tree and
     > have been using it since then. The problem has been reduced. I
     > thought it was fixed, but just as I sent this message, I tried
     > my little test again, and in one of the three runs I had a 21
     > second stall. I waited a few minutes between tests.

     > Is your patch meant for the latest BK tree? Or something older?

The patch should apply fine to the latest BK tree: there have been no
recent changes that might affect it.

Cheers,
   Trond
