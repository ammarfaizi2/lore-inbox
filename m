Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264196AbRFFWQL>; Wed, 6 Jun 2001 18:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264197AbRFFWPv>; Wed, 6 Jun 2001 18:15:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62346 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264196AbRFFWPl>;
	Wed, 6 Jun 2001 18:15:41 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15134.43914.98253.998655@pizda.ninka.net>
Date: Wed, 6 Jun 2001 15:15:38 -0700 (PDT)
To: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>
Cc: "Matt D. Robinson" <yakker@alacritech.com>, linux-kernel@vger.kernel.org,
        sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <15134.42714.3365.32233@theor.em.cig.mot.com>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
	<3B1E5CC1.553B4EF1@alacritech.com>
	<15134.42714.3365.32233@theor.em.cig.mot.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


La Monte H.P. Yarroll writes:
 > Matt D. Robinson writes:
 >  > Is there any way to add in the capability to _replace_ TCP with
 >  > your own, so you can use your own layer?

ABSOLUTELY NOT!

And I will never in my lifetime allow such a facility to be added to
the Linux kernel.

This allows people to make proprietary implementations of TCP under
Linux.  And we don't want this just as we don't want to add a way to
allow someone to do a proprietary Linux VM.

Later,
David S. Miller
davem@redhat.com
