Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268528AbTBWTT2>; Sun, 23 Feb 2003 14:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268529AbTBWTT2>; Sun, 23 Feb 2003 14:19:28 -0500
Received: from palrel11.hp.com ([156.153.255.246]:64719 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S268528AbTBWTT2>;
	Sun, 23 Feb 2003 14:19:28 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15961.8482.577861.679601@napali.hpl.hp.com>
Date: Sun, 23 Feb 2003 11:29:38 -0800
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <b3b6oa$bsj$1@penguin.transmeta.com>
References: <E18moa2-0005cP-00@w-gerrit2>
	<Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
	<20030223082036.GI10411@holomorphy.com>
	<b3b6oa$bsj$1@penguin.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 23 Feb 2003 19:17:30 +0000 (UTC), torvalds@transmeta.com (Linus Torvalds) said:

  Linus> Look at them the right way and you realize that a lot of the
  Linus> grottyness is exactly _why_ the x86 works so well (yeah, and
  Linus> the fact that they are everywhere ;).

But does x86 reall work so well?  Itanium 2 on 0.13um performs a lot
better than P4 on 0.13um.  As far as I can guess, the only reason P4
comes out on 0.13um (and 0.09um) before anything else is due to the
latter part you mention: it's where the volume is today.

	--david
