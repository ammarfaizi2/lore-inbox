Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137070AbRA1OKH>; Sun, 28 Jan 2001 09:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137110AbRA1OJ5>; Sun, 28 Jan 2001 09:09:57 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:19380 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S137070AbRA1OJq>;
	Sun, 28 Jan 2001 09:09:46 -0500
Date: Sun, 28 Jan 2001 14:09:19 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Ben Ford <ben@kalifornia.com>
cc: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <3A7426E1.728BB87D@kalifornia.com>
Message-ID: <Pine.SOL.4.21.0101281406560.21057-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Ben Ford wrote:

> James Sutherland wrote:
> 
> > I'm sure we all know what the IETF is, and where ECN came from. I haven't
> > seen anyone suggesting ignoring RST, either: DM just imagined that,
> > AFAICS.
> >
> > The one point I would like to make, though, is that firewalls are NOT
> > "brain-damaged" for blocking ECN: according to the RFCs governing
> > firewalls, and the logic behind their design, blocking packets in an
> > unknown format (i.e. with reserved bits set) is perfectly legitimate. Yes,
> > those firewalls should be updated to allow ECN-enabled packets
> > through. However, to break connectivity to such sites deliberately just
> > because they are not supporting an *experimental* extension to the current
> > protocols is rather silly.
> 
> Do keep in mind, we aren't breaking connectivity, they are.

Let me guess: you're a lawyer? :-)

This is a very strange definition: if someone makes a change such that
their machine can no longer communicate with existing systems, I would say
the person making the incompatible change is the one who broke it.

Maybe my mains sockets should be waterproof: it's still my fault when
pouring water over them causes problems, even if the standards say the
socket should be waterproof!


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
