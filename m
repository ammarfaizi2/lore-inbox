Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129334AbRA2T1v>; Mon, 29 Jan 2001 14:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRA2T1m>; Mon, 29 Jan 2001 14:27:42 -0500
Received: from entropy.muc.muohio.edu ([134.53.213.10]:27264 "EHLO
	entropy.muc.muohio.edu") by vger.kernel.org with ESMTP
	id <S132786AbRA2T1b>; Mon, 29 Jan 2001 14:27:31 -0500
Date: Mon, 29 Jan 2001 14:27:13 -0500 (EST)
From: George <greerga@entropy.muc.muohio.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: "David S. Miller" <davem@redhat.com>, James Sutherland <jas88@cam.ac.uk>,
        Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <200101291831.f0TIV7h484162@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.30.0101291423000.2416-100000@entropy.muc.muohio.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Albert D. Cahalan wrote:

>The author is expressing his wish for an ideal world. Note that he
>also accepts reality. He accepts that PMTU black holes won't go
>away, even though we might like them to do so.
>
>Hell, I think I'm behind one. ICMP is/was blocked to/from/within
>the entire university. This was to stop ping flood attacks. :-)

So you get a UDP flood instead.

Congratulations on breaking something important (PMTU, "Port unreachable",
etc.) for a false sense of security.

Did you buy a non-upgraded Cisco PIX just to block ECN as well?

-George Greer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
