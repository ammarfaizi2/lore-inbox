Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136447AbREINen>; Wed, 9 May 2001 09:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136446AbREINee>; Wed, 9 May 2001 09:34:34 -0400
Received: from netcore.fi ([193.94.160.1]:64011 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S136445AbREINeX>;
	Wed, 9 May 2001 09:34:23 -0400
Date: Wed, 9 May 2001 16:34:01 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Matthew Geier <matthew@sleeper.apana.org.au>
cc: jamal <hadi@cyberus.ca>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>, <linux-net@vger.rutgers.edu>,
        Sally Floyd <floyd@aciri.org>, <kk@teraoptic.com>, <jitu@aciri.org>
Subject: Re: ECN: Volunteers needed
In-Reply-To: <20010509114437.AD213709E@sleeper.apana.org.au>
Message-ID: <Pine.LNX.4.33.0105091559260.27312-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2001, Matthew Geier wrote:
> > This is to solicit volunteers who will help removing the remaining cruft.
> > Some vendors (special positive mention goes to CISCO) have released
> > patches which are unfortunately not being propagated by some of the
> > site owners.
> > Help is needed to contact these site owners and politely using a standard
> > email ask them that their site was non-conformant.
>
>
>  I tried to get my local bank to fix their internet banking service about a
> month ago. I ran into a 'brick wall'. They only support Windows and MacOS,
> since neither currently implement ECN, they don't have a problem :-(
>
>  The only answer I got is 'we don't support Linux'. The operator tried
> to find some one interested in the network, but the answer was always
> the same. 'We don't support.....'
[snip]

There are a couple of ways to deal with these:

 0) speak to the right persons: don't expect helpdesk can do anything
about these, especially don't expect anyone to "call you back".  Try to
get in touch with someone who is a network admin; if the bank is not a
kiosk with tiny amount of money in the safe, a whois database e.g. RIPE
might give some clues.  If helpdesk/network admin is clueless, ask to
speak with their supervisor.

 1) vote with your feet: switch the bank.  This is how modern economy
works; money is power.  Make sure they know you switched (or intend to
switch) banks, and why.  Make sure their boss, and the person somewhat in
charge of handling customer relations, knows it.

 2) make it (more) public: if there are potentially more people in the
area who this would concern, making this public, and causing the bank a
potential loss of 50 customers, not 1, might wake them to the reality.

 3) forget about it: just don't enable ECN.

And lastly: do not make them think of this as a Linux problem.  Their
software breaks Internet standards (soon, anyway :), and eventually they
will be shut out.  In many cases, the fix is free and easily installable.

.. Let's not start a huge thread (especially with this big Cc: list; there
should be a smaller forum to discuss this if necessary) on this though.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords


