Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQLHP1r>; Fri, 8 Dec 2000 10:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLHP1i>; Fri, 8 Dec 2000 10:27:38 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5134 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129414AbQLHP1a>;
	Fri, 8 Dec 2000 10:27:30 -0500
Message-ID: <3A30F68F.50076AA7@mandrakesoft.com>
Date: Fri, 08 Dec 2000 09:56:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Horton <pdh@colonel-panic.com>
CC: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: D-LINK DFE-530-TX
In-Reply-To: <Pine.LNX.4.30.0012061942570.620-100000@asdf.capslock.lan> <20001208012321.A1732@colonel-panic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Horton wrote:
> 
> On Wed, Dec 06, 2000 at 07:44:02PM -0500, Mike A. Harris wrote:
> > Which ethernet module works with this card?  2.2.17 kernel
> >
> 
> If the PCI device ID is 3065 then it's via-rhine, but not supported by the
> driver in the kernel. Get updated via-rhine from Donald Becker's site
> http://www.scyld.com/network.

2.4.x-test has some fixes for via-rhine which don't appear to have made
it into the Becker driver yet...

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
