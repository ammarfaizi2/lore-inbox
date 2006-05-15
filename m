Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWEOIhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWEOIhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWEOIhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:37:18 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:15543 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964826AbWEOIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:37:16 -0400
Date: Mon, 15 May 2006 04:36:55 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm 00/02] Update rt-mutex-design.txt per Randy Dunlap
Message-ID: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following two patches are updates to the rt-mutex-design.txt document
which were suggested by Randy Dunlap.  The first patch fixes the problems
that Randy pointed out.  The second patch changes some indentation. I
separated the two so that people can review the changes without having to
look through the big diffs that the indentation made.

Randy,

Could you check to see if I hit all your concerns.  I might have missed
some.

Andrew,

I'm sober this time ;)

-- Steve

