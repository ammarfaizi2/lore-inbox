Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268987AbTBWVvG>; Sun, 23 Feb 2003 16:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268988AbTBWVvF>; Sun, 23 Feb 2003 16:51:05 -0500
Received: from palrel12.hp.com ([156.153.255.237]:41621 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S268987AbTBWVvE>;
	Sun, 23 Feb 2003 16:51:04 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15961.17579.89978.78291@napali.hpl.hp.com>
Date: Sun, 23 Feb 2003 14:01:15 -0800
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <9280000.1046031179@[10.10.2.4]>
References: <E18moa2-0005cP-00@w-gerrit2>
	<Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
	<20030223082036.GI10411@holomorphy.com>
	<b3b6oa$bsj$1@penguin.transmeta.com>
	<15961.8482.577861.679601@napali.hpl.hp.com>
	<9280000.1046031179@[10.10.2.4]>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 23 Feb 2003 12:13:00 -0800, "Martin J. Bligh" <mbligh@aracnet.com> said:

  Linus> Look at them the right way and you realize that a lot of the
  Linus> grottyness is exactly _why_ the x86 works so well (yeah, and
  Linus> the fact that they are everywhere ;).

  >>  But does x86 reall work so well?  Itanium 2 on 0.13um performs a
  >> lot better than P4 on 0.13um.  As far as I can guess, the only
  >> reason P4 comes out on 0.13um (and 0.09um) before anything else
  >> is due to the latter part you mention: it's where the volume is
  >> today.

  Martin> Care to share those impressive benchmark numbers (for
  Martin> macro-benchmarks)?  Would be interesting to see the
  Martin> difference, and where it wins.

You can do it two ways: you can look at the numbers Intel is publicly
projected for Madison, or you can compare McKinley with 0.18um Pentium 4.

	--david
