Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265521AbSJXQH3>; Thu, 24 Oct 2002 12:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265525AbSJXQH2>; Thu, 24 Oct 2002 12:07:28 -0400
Received: from h66-38-216-165.gtconnect.net ([66.38.216.165]:59909 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S265521AbSJXQH1>;
	Thu, 24 Oct 2002 12:07:27 -0400
Date: Thu, 24 Oct 2002 12:13:38 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Tony Gale <gale@syntax.dstl.gov.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
In-Reply-To: <1035453664.1035.11.camel@syntax.dstl.gov.uk>
Message-ID: <Pine.LNX.4.44.0210241209250.648-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Oct 2002, Tony Gale wrote:

> Date: 24 Oct 2002 11:01:04 +0100
> From: Tony Gale <gale@syntax.dstl.gov.uk>
> To: linux-kernel@vger.kernel.org
> Subject: Re: One for the Security Guru's
>
> On Thu, 2002-10-24 at 10:38, Henning P. Schmiedehausen wrote:
> > Gerhard Mack <gmack@innerfire.net> writes:
> >
> > >Actually at the place that just went bankrupt on me I had a Security
> > >consultant complain that 2 of my servers were outside the firewall.  He
> > >recommended that I get a firewall just for those 2 servers but backed off
> > >when I pointed out that I would need to open all of the same ports that
> > >are open on the server anyways so the vulnerability isn't any less with
> > >the firewall.
> >
> > So you should've bought a more expensive firewall that offers protocol
> > based forwarding instead of being a simple packet filter.
> >
> > packet filter != firewall. That's the main lie behind most of the
> > "Linux based" firewalls.
> >
> > Get the real thing. Checkpoint. PIX. But that's a little
> > more expensive than "xxx firewall based on Linux".
> >
>
> Thats not entirely accurate, or fair. A packet filter is a type of
> Firewall (or can be). A Firewall is a means to implement a security
> policy, usually specifically a network access policy. A Packet Filter,
> including a ""Linux based" firewall" is a perfectly acceptable means of
> achieving that goal, if it meets the policy requirements.
>
> Ref. http://csrc.nist.gov/publications/nistpubs/800-10/ (over 7 years
> old, but still highly relevant).
>
> Most commercial firewalls are very bad at protecting servers offering
> Internet services, they aren't designed to do it.
>

It gets even worse if almost all of your services are encrypted(like you
would find on an e-commerse site).  https will blind an IDS.  The last
place I worked only had 3 ports open and 2 of them were encrypted.

	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

