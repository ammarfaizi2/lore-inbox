Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbRA1Pf6>; Sun, 28 Jan 2001 10:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132290AbRA1Pfs>; Sun, 28 Jan 2001 10:35:48 -0500
Received: from james.kalifornia.com ([208.179.0.2]:48999 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131410AbRA1Pfh>; Sun, 28 Jan 2001 10:35:37 -0500
Message-ID: <3A743CE4.A13A7878@kalifornia.com>
Date: Sun, 28 Jan 2001 07:38:12 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: James Sutherland <jas88@cam.ac.uk>
CC: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.SOL.4.21.0101281406560.21057-100000@red.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:

> On Sun, 28 Jan 2001, Ben Ford wrote:
>
> > James Sutherland wrote:
> >
> > > I'm sure we all know what the IETF is, and where ECN came from. I haven't
> > > seen anyone suggesting ignoring RST, either: DM just imagined that,
> > > AFAICS.
> > >
> > > The one point I would like to make, though, is that firewalls are NOT
> > > "brain-damaged" for blocking ECN: according to the RFCs governing
> > > firewalls, and the logic behind their design, blocking packets in an
> > > unknown format (i.e. with reserved bits set) is perfectly legitimate. Yes,
> > > those firewalls should be updated to allow ECN-enabled packets
> > > through. However, to break connectivity to such sites deliberately just
> > > because they are not supporting an *experimental* extension to the current
> > > protocols is rather silly.
> >
> > Do keep in mind, we aren't breaking connectivity, they are.
>
> Let me guess: you're a lawyer? :-)
>
> This is a very strange definition: if someone makes a change such that
> their machine can no longer communicate with existing systems, I would say
> the person making the incompatible change is the one who broke it.
>
> Maybe my mains sockets should be waterproof: it's still my fault when
> pouring water over them causes problems, even if the standards say the
> socket should be waterproof!
>

Bad analogy.  Try this.  Jim-Bob down at your local Post Office starts rejecting
all your mail that has the 4 digit zip code extension (Not in wide use, but a
"proposed standard") because he's old school and doesn't know what it is -- maybe
its secret spy communications!!!

(Although this would have the side benefit of really reducing the amount of junk
mail received . . . . . . )

And no, I'm not a lawyer.

-b


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
