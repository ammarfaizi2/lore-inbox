Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130405AbRAVDck>; Sun, 21 Jan 2001 22:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbRAVDcb>; Sun, 21 Jan 2001 22:32:31 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:41861 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S130405AbRAVDcQ>;
	Sun, 21 Jan 2001 22:32:16 -0500
Message-ID: <3A6BA9A2.A9E043FF@pobox.com>
Date: Sun, 21 Jan 2001 19:31:46 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8-ll i586)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: Paul Barton-Davis <pbd@op.net>, yodaiken@fsmlabs.com,
        Andrew Morton <andrewm@uow.edu.au>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:

> Yes, I most emphatically do disagree with Victor!  IRIX is used for
> mission-critical audio applications - recording as well playback - and
> other low-latency applications.  The same OS scales to large numbers of
> CPUs.  And it has the best desktop interactive response of any OS I've
> used.  I will be very happy when Linux is as good in all these areas,
> and I'm working hard to achieve this goal with negligible impact on the
> current Linux "sweet-spot" applications such as web serving.

I have to agree - when I worked at the University of California,
a number of us had SGI Indys in our offices. The desktop was
lightning fast, and the graphics were awesome. This is no news
to anybody, since SGI is known for graphics. The big surprise,
however, came when we were trying to find the best nfs server
platform, and benchmarked the SGI just for fun - as it turns out,
a little Indy workstation blew away all other platforms, including
some rather large expensive SPARC boxes, as an nfs server.

So Irix clearly showed the best of both worlds - great latency
and great throughput.

I guess what I'm saying is, there are a lot of proven concepts
in Irix, which work well in real life situations - don't throw out the
baby with the bath water -

jjs




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
