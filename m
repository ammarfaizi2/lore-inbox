Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbREMHqY>; Sun, 13 May 2001 03:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbREMHqO>; Sun, 13 May 2001 03:46:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1960 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261385AbREMHqF>;
	Sun, 13 May 2001 03:46:05 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15102.15280.99363.687534@pizda.ninka.net>
Date: Sun, 13 May 2001 00:45:52 -0700 (PDT)
To: Ben Greear <greearb@candelatech.com>
Cc: Matthew Kirkwood <matthew@hairy.beasts.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <3AFE2BAB.DB8C03F0@candelatech.com>
In-Reply-To: <Pine.LNX.4.30.0105071730090.23021-100000@sphinx.mythic-beasts.com>
	<3AFE2BAB.DB8C03F0@candelatech.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben Greear writes:
 > If it was good enough for 2.2.19, shouldn't it be good enough for
 > 2.4?

Actually, by itself, this is a bogus argument.  Many things in
2.2.x have been explicitly removed in 2.4.x :-)

Regardless, the arp filter in some form will be added.  Don't
worry.

Later,
David S. Miller
davem@redhat.com
