Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKAAO7>; Tue, 31 Oct 2000 19:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130049AbQKAAOt>; Tue, 31 Oct 2000 19:14:49 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:59922 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129130AbQKAAOl>; Tue, 31 Oct 2000 19:14:41 -0500
Date: Tue, 31 Oct 2000 19:13:32 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Michael H. Warfield" <mhw@wittsend.com>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>, npsimons@fsmlabs.com,
        Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031191332.A27820@alcove.wittsend.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	"Jeff V. Merkey" <jmerkey@timpanogas.org>, npsimons@fsmlabs.com,
	Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20001031190034.B24279@alcove.wittsend.com> <E13qlRY-0008S3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <E13qlRY-0008S3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 01, 2000 at 12:07:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 12:07:50AM +0000, Alan Cox wrote:
> > users must be fairly recent (4.x and about - 3.x has come into discussion
> > but doesn't count here) customers.  Obviously, they are big and SIGNIFICANT
> > customers.  Do we know that Linux can't handle the load, though, or is
> > this just more supposition based on statistics?

> On the same hardware netware 3 at least tended to beat us flat, but then it
> wasnt a general purpose OS. I think what Jeff is trying to build is basically
> a box that runs netware in the netware 3/4 style - ie fast and a little 
> unprotected with a standard linux application space protected mode on top of it
> - its an interesting concept.

	Alan, I'll grant that what Jeff is attempting to do is laudable.
It's just that I have experience with Netware 3.x and 4.x in the field
(Ok...  More 3.x than 4.x) and I have more than passing familiarity with
5.x security problems.  I know he wants to achieve some of the good things
that Novell managed.  I know, from first hand experience, what cost some
of those come at.  Can he achieve the goal of matching the good while
avoiding the bad?  I hope so.  He won't do it by promoting what he
perceives as the advantages of Novell over Linux without at least some
passing acknowledgement of the failures of Novell, the disadvantages, and
the costs.  I think his goals are good and his head is in the right spot,
I just don't want to see history repeat itself.  He has my best wishes,
since both he and Linux will benefit.

	My $0.02.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
