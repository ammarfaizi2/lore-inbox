Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEH2X>; Fri, 5 Jan 2001 02:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129641AbRAEH2N>; Fri, 5 Jan 2001 02:28:13 -0500
Received: from innerfire.net ([208.181.73.33]:34320 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S129387AbRAEH2B>;
	Fri, 5 Jan 2001 02:28:01 -0500
Date: Thu, 4 Jan 2001 23:30:24 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Andre Tomt <andre@tomt.net>
cc: linux-kernel@vger.kernel.org
Subject: RE: Change of policy for future 2.2 driver submissions
In-Reply-To: <OPECLOJPBIHLFIBNOMGBIEGLCHAA.andre@tomt.net>
Message-ID: <Pine.LNX.4.10.10101042319110.3934-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Andre Tomt wrote:

> I would wait for at least 2.4.10 on production systems (servers in
> particular). Not to start a flame or anything (yeah, right), but 2.2.x was
> not usable on such systems before it reached 2.2.16 IMHO.
> 
> So, I guess, the "crippling" of driver submissions could hurt me bit, in
> theory, which I don't like. ;-)

I don't remember 2.2.0 being this well tested... I seem to recall it
having a huge list of known bugs at the time too.

2.4.0 seems to have come with much better bug tracking and the time was
spent fixing those bugs.

Some of the servers I ran at the time wouldn't stabilize until 2.2.7 ..
I'm betting on things going much more smoothly (though I won't know
for sure since that company lost it's ability to afford me ;) ) 	

	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
