Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130083AbQKUXBq>; Tue, 21 Nov 2000 18:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129708AbQKUXBg>; Tue, 21 Nov 2000 18:01:36 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:31762 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129325AbQKUXBc>;
	Tue, 21 Nov 2000 18:01:32 -0500
Date: Tue, 21 Nov 2000 23:31:21 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: David Riley <oscar@the-rileys.net>
cc: Jeff Epler <jepler@inetnebr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <3A1AF6AC.F7208DC@the-rileys.net>
Message-ID: <Pine.LNX.4.30.0011212330130.3193-100000@toor.thn.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Riley wrote:

> Jeff Epler wrote:
> >
> > On Tue, Nov 21, 2000 at 04:08:26PM -0500, David Riley wrote:
> > > Windoze is not the only OS to handle bad hardware better than Linux.  On
> > > my Mac, I had a bad DIMM that worked fine on the MacOS side, but kept
> > > causing random bus-type errors in Linux.  Same as when I accidentally
> > > (long story) overclocked the bus on the CPU.  I think that more
> > > tolerance for faulty hardware (more than just poorly programmed BIOS or
> > > chipsets with known bugs) is something that might be worth looking into.
> >
> > And how do you propose to do that?
> >
> > For instance, in some other operating systems having the top bit flip
> > in a pointer will cause silent use of incorrect data.  On Linux, this
> > will cause a signal 11.  Which do you prefer, bad results or an error
> > message?
> >
> > Can you suggest a specific way in which Linux can react correctly to
> > e.g. flipped bits in RAM or cache which cannot be detected at the hardware
> > level?  Or maybe tell me how Linux can react correctly when an overclocked
> > CPU starts producing incorrect results for right shifts once every few
> > thousand instructions?
>
> Hmm... Good point.  That would be hard to do.  On that note, there
> should be some prominent note on things like user manuals (though Linux
> users shouldn't need *manuals* :-) that notes that common crashes like
> signal 11 or "cc: internal failure" messages are generally caused by
> hardware problems.

Well David, there is such a "manual".

http://ftp.sunet.se/LDP/FAQ/faqs/GCC-SIG11-FAQ



/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Gve8USLExYo23RsRAtrQAJ4glySTwLB+e02mlYX0L42pf3+8BACdEssx
L2fhmp7uY+xa3wpWYt6cb+M=
=aP6d
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
