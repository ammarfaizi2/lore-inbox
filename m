Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129956AbQLEIAh>; Tue, 5 Dec 2000 03:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbQLEIA2>; Tue, 5 Dec 2000 03:00:28 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2066 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129835AbQLEIAP>; Tue, 5 Dec 2000 03:00:15 -0500
Date: Tue, 5 Dec 2000 01:25:07 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        pavel@suse.cz, kernel@blackhole.compendium-tech.com, hps@tanstaafl.de,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Fasttrak100 questions...
Message-ID: <20001205012507.A6216@vger.timpanogas.org>
In-Reply-To: <20001202182126.A20944@vger.timpanogas.org> <200012030342.WAA17517@tsx-prime.MIT.EDU> <20001202221146.A21761@vger.timpanogas.org> <20001205010730.A5760@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001205010730.A5760@openss7.org>; from bidulock@openss7.org on Tue, Dec 05, 2000 at 01:07:30AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 01:07:30AM -0600, Brian F. G. Bidulock wrote:
> Jeff,
> 
> Have you also seen this applied where it is to the employer's
> disadvantage?  For example, given that I looked at and worked
> with GPL code (say Linux kernel) in University before taking
> employment as a programmer that the employer's product is
> inevitably contaiminated and no longer a trade secret?  Can
> a previous employee get an injunction against their former
> employer to cease and desist from using this negative knowledge?
> 
> If so, I might have a solution: make the Linux kernel required
> reading in University programming classes!

Trade Secrets are defined by something called the Uniform Tade Secret
Act, which has been adopted in most states.  It calls for several points
that must be met in order for something to be protected as a "trade
secret".  Before this act, Muna vs. Microbiological (1964) was one of the 
landmark cases outlining trade secret law in the US.  A lot has happened 
since Muna, but basically, these are the points.

1.  A trade secret, must of course, be a "secret".
2.  Cannot be readily ascertainable to someone skilled in the art.
3.  Reasonable safegards must have been taken to protect it's secrecy.
4.  Must have indendent economic value.

Technically, based on the premise of negative knowledge, someone could
work for company A trying to build a software product, and fail at
each attempt, thereby, accumulating negative knowledge.  This person
could then quit and go to work for Company B, build the same
product, this time completing it, using previous negative
knowledge gained from Company A.  If Company A, had an agreement
respecting trade secrets, under inevitability, Company A could
claim the Company B's product was based on their IP if the 
employee did it within 18 months of departing Company A.

This is why I think inevitability is a ridculous doctrine.  It
makes claim to the work experinece of employees as IP.

In theory, an employee could not obtain the injunction because 
he would have no standing to bring a cause of action, but the copyright
holder would have standing and could if he could show that the 
employee used negative knowledge and that he did so within a 
certain period of time.  It's even more complicated, trade 
secret law makes claims that common software components 
arranged in new ways would qualify as a trade secret.  This could
also mean that any new software this person wrote would 
necessarily be intertwined with GPL code and trade secrets of
the employer.  In such a case, a Judge would "balance the 
equities", and would have to make a call, like telling the company
to remove the GPL sections, and/or requireing the portions of the
code be open sourced.  He could also go the other way, and rule
some sections are not covered under inevitablity.

It would be a very complex case, BTW (trade secrets cases always 
are).

:-)

Jeff



> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
