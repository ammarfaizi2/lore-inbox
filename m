Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264250AbRFFXbr>; Wed, 6 Jun 2001 19:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264254AbRFFXbh>; Wed, 6 Jun 2001 19:31:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45707 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264250AbRFFXbZ>;
	Wed, 6 Jun 2001 19:31:25 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15134.48456.5360.764458@pizda.ninka.net>
Date: Wed, 6 Jun 2001 16:31:20 -0700 (PDT)
To: "Matt D. Robinson" <yakker@alacritech.com>
Cc: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <3B1EBB13.34721ED9@alacritech.com>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
	<3B1E5CC1.553B4EF1@alacritech.com>
	<15134.42714.3365.32233@theor.em.cig.mot.com>
	<15134.43914.98253.998655@pizda.ninka.net>
	<3B1EBB13.34721ED9@alacritech.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt D. Robinson writes:
 > > This allows people to make proprietary implementations of TCP under
 > > Linux.  And we don't want this just as we don't want to add a way to
 > > allow someone to do a proprietary Linux VM.
 > 
 > And if as Joe User I don't want Linux TCP, but Joe's TCP, they can't
 > do that (in a supportable way)?  Are you saying Linux is, "do it my
 > way, or it's the highway"?

If Joe's TCP is opensource, they are more than welcome to publish such
changes.

The loadable module functionality allows proprietary binary-only
drivers for devices, not binary-only proprietary reimplementations of
core parts of the kernel.

Ask Linus himself if you do not believe me and you think my position
stinks.  He's the person you have to convince in the end.

Later,
David S. Miller
davem@redhat.com
