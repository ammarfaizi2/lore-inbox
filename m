Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263093AbRFGFqc>; Thu, 7 Jun 2001 01:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbRFGFqX>; Thu, 7 Jun 2001 01:46:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45198 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263093AbRFGFqM>;
	Thu, 7 Jun 2001 01:46:12 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15135.5403.953462.861700@pizda.ninka.net>
Date: Wed, 6 Jun 2001 22:46:03 -0700 (PDT)
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        <linux-kernel@vger.kernel.org>, <sctp-developers-list@cig.mot.com>
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
 table
In-Reply-To: <Pine.LNX.4.30.0106062153540.3846-100000@nakedeye.aparity.com>
In-Reply-To: <200106062351.f56NpOs20522@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.30.0106062153540.3846-100000@nakedeye.aparity.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt D. Robinson writes:
 > P.S.  I guess the next thing on the list for the Linux kernel is to
 >       create WHQL-like process for drivers before the code can end up
 >       in newer kernel revisions.  Then I'll really know things have gone
 >       into the toilet.

Just remember that the allowance of proprietary device driver kernel
modules is a special exception to the licensing of the kernel, not the
rule.  And some days even this exception becomes close to regrettable.

Other people seem to appreciate when the GPL camp isn't telling them
how to license their own code.  And just as fairly it'd be nice if
people didn't tell us what to do with the licensing of the Linux
sources.

(I'm not a "use opensource or you're a maggot" person, I just choose
 to not assosciate myself with sources not using that kind of
 licensing.  Linux is one of those safe havens for myself and
 others.  How would you like it if I were to jeapordize your own
 legitimate paradise?).

Later,
David S. Miller
davem@redhat.com

