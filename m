Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRA2UAW>; Mon, 29 Jan 2001 15:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRA2UAO>; Mon, 29 Jan 2001 15:00:14 -0500
Received: from smi-057.smith.uml.edu ([129.63.206.57]:62991 "HELO
	buick.pennace.org") by vger.kernel.org with SMTP id <S129235AbRA2T7z>;
	Mon, 29 Jan 2001 14:59:55 -0500
Date: Mon, 29 Jan 2001 14:59:50 -0500
From: Alex Pennace <alex@pennace.org>
To: George <greerga@entropy.muc.muohio.edu>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010129145950.A6208@buick.pennace.org>
Mail-Followup-To: George <greerga@entropy.muc.muohio.edu>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200101291831.f0TIV7h484162@saturn.cs.uml.edu> <Pine.LNX.4.30.0101291423000.2416-100000@entropy.muc.muohio.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.30.0101291423000.2416-100000@entropy.muc.muohio.edu>; from greerga@entropy.muc.muohio.edu on Mon, Jan 29, 2001 at 02:26:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 02:26:51PM -0500, George wrote:
> On Mon, 29 Jan 2001, Albert D. Cahalan wrote:
> >The author is expressing his wish for an ideal world. Note that he
> >also accepts reality. He accepts that PMTU black holes won't go
> >away, even though we might like them to do so.
> >
> >Hell, I think I'm behind one. ICMP is/was blocked to/from/within
> >the entire university. This was to stop ping flood attacks. :-)
> 
> So you get a UDP flood instead.
> 
> Congratulations on breaking something important (PMTU, "Port unreachable",
> etc.) for a false sense of security.

Your praise should be directed to UML telecommunications.

> Did you buy a non-upgraded Cisco PIX just to block ECN as well?

I wouldn't doubt it, but I haven't tested it on this network.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
