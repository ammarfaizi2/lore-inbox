Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131113AbQKBAAQ>; Wed, 1 Nov 2000 19:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131433AbQKAX75>; Wed, 1 Nov 2000 18:59:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11919 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131113AbQKAX7p>;
	Wed, 1 Nov 2000 18:59:45 -0500
Date: Wed, 1 Nov 2000 15:45:24 -0800
Message-Id: <200011012345.PAA20284@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: cort@fsmlabs.com
CC: npsimons@fsmlabs.com, garloff@suse.de, jamagallon@able.es,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001101165418.B3444@hq.fsmlabs.com> (message from Cort Dougan
	on Wed, 1 Nov 2000 16:54:18 -0700)
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net> <20001101163752.B2616@fsmlabs.com> <200011012329.PAA19890@pizda.ninka.net> <20001101165418.B3444@hq.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Wed, 1 Nov 2000 16:54:18 -0700
   From: Cort Dougan <cort@fsmlabs.com>

   Since you're setting yourself up as a proponent of this can you
   explain why RedHat includes a compiler that doesn't work with the
   kernel?

Because the kernel is buggy (the specifics of this has been discussed
before on this list) and we didn't have time to implement and QA the
changes needed in time for the 7.0 release.

Furthermore I was correcting Nathan's statement that this was a "Red
Hat thing", not specifically upholding the virtues of using a
different compiler for the kernel.  That is a completely seperate
topic and we've had that taken that conversation as far as it will go
already remember? :-)

Finally, if I were to state "fsmlabs are a bunch of pinheads because
they did XXX" I would expect you to defend your employer as well if I
misrepresented them due to incorrect statements.  Right?  :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
