Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbRGOSIF>; Sun, 15 Jul 2001 14:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266802AbRGOSH4>; Sun, 15 Jul 2001 14:07:56 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:43178 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S266793AbRGOSHs>; Sun, 15 Jul 2001 14:07:48 -0400
Date: Sun, 15 Jul 2001 14:07:23 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, Matti Aarnio <matti.aarnio@zmailer.org>,
        linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org
Subject: Re: ORBS blacklist is BROKEN (deliberately)...
Message-ID: <20010715140723.C28197@alcove.wittsend.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Keith Owens <kaos@ocs.com.au>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org
In-Reply-To: <10249.995101943@ocs3.ocs-net> <E15LOMk-00018x-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <E15LOMk-00018x-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jul 14, 2001 at 01:17:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 01:17:46PM +0100, Alan Cox wrote:
> > http://www.e-scrub.com/orbs/ is the key.  "Ronald F. Guilmette"
> > <rfg@monkeys.com> sent this message to spam lists.  Anybody still using
> > ORBS for lookups can expect to get random mail bounces.

> Yeah he's decided to solve his load problem by committing an act of criminal
> fraud, computer misuse and a few other violations

	I can't find any crimes or violations that he's commiting.
His ethics may suck, but his system is being used against his explicitly
stated wishes.  Personally, I think he would have been better off
rejecting everything and then people still using ORBS would see the
quality of the service drop as their SPAM level rose.  But that's still
tantamount to the same thing.  The information he is supplying is
false and people are relying on that information.  But he's not obligated
to provide that information, in the first place, and there is NO
guarantee of reliability of that information.  The real solution is
to get his name server out of the list for those zones.

	He is also not committing any sort of fraud, either.  He is
stating right up front that this information is wrong.  He's not
pretending that it's anything else other than false.  The whole
system is dead, so he has no way to provide accurate information, so
I would say he's being a lot more honest than the other 10 name servers
which continue to answer queries as if nothing has changed.  Now THAT'S
a possibility for fraud.

	Computer misuse?  No...  I don't think so.  His computer is being
missused, sort of, but he's not misusing anyone elses computer.  He's
not forcing them to rely on his information and he's even stating to
everyone that the information is wrong.  But with the demise of ORBS
there is no way on God's green earth of the information being right,
anyways...

> > Because of the way Alan disabled the former ORBS list zones, my name
> > server is now shouldering (at least) 1/11th of the total world-wide

> [I think he means the way the courts did..]

	It's probably the way the zones were left hanging with NS records
pointing at him that he can't control.  Problem goes away if someone can
take his server out of the NS list.  It's a techincal issue, not a legal
issue, with regards to this one server.  Doesn't change the fact that
all the rest of the servers are serving up responses that are going to
be increasingly out of date and inaccurate.  Is that any better than
information that is just flat out uniformly wrong, and admits it?

> And guess what, as soon as ORBS got beaten off the net MAPS starts talking
> about charging for their service, just like they promised they never would

	Sigh...

> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-admin" in
> the body of a message to majordomo@vger.kernel.org

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

