Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269620AbUJWAhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269620AbUJWAhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269618AbUJWAfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:35:20 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:55301 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S269388AbUJWAY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:24:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <jonathan@jonmasters.org>
Cc: "brian wheeler" <bdwheele@indiana.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux v2.6.9 and GPL Buyout
Date: Fri, 22 Oct 2004 17:24:36 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEJBPDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <417990AE.5050806@drdos.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 22 Oct 2004 17:01:32 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 22 Oct 2004 17:01:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Darl seemed like a nice enough sort, but he doesn't care much for Linux
> or IBM and he's pretty harsh
> on IBM. We argued for 30 minutes about SMP support in Linux and I think
> he will just let this one go since
> I pointed out that Novell had disclosed the Unixware SMP stuff at
> Brainshare and he cannot claim
> it as trade secrete any longer. He would not budge on RCU, NUMA, JFS, or
> XFS however, and he
> also said any IBM employee who contributed SMP code in his opinion may
> have misappropriated it
> and he would claim any contribution from any IBM employee in Linux.

	IANAL, but I'm pretty sure you can't go after innocent third parties for
trade secrets or misappropriated intellectual property. That's what we have
copyright and patent for. He can certainly go after the people who actually
stole the trade secrets or misappropriated the intellectual property, but
only copyright and patent provide the public notification requirements that
permit one to sustain claims against innocent third parties (those who use
the stolen/misappropriated property without any knowledge that it was stolen
or misappropriated).

	If he's trying to claim that any use subsequent to some point at which we
are supposed to have known that it was stolen or misappropriated, a listing
by category is not anywhere near sufficient, IMO. Even files and line ranges
don't suffice. He would have to provide us with sufficient information to
*verify* the *credibility* of his claim. This has never been done. The
biggest missing piece is *what* it is that has been stolen.

	If it's conceptual ideas, like the idea of SMP but not the code, then he's
just totally out of his mind. Only patent provides that type of broad
protection. If it's a 'derived work' type argument (that we stole something
from him and changed it, so it's not literally the same but still his
property), then he's again totally out of his mind. Only copyright provides
that type of protection.

	In any event, it's self-defeating, IMO, to act on SCO's claims at this
point. Until they're well enough defined that it's possible for us to
investigate them, we are still innocent third party victims of someone
else's misappropriation. And that's not our problem. Again, IANAL.

	One other issue with trying to work with SCO just to prevent future
problems -- SCO has already offered bogus immunities from liability. So I
wouldn't trust any immunity you even think you have. Especially since we
don't know what it is we're supposed to be immune *from*. (Is it copyright?
Is it trade secret? Is it fruit of some kind of poisonous tree because IBM
violated the spirit of some contract none of us are a party to?)

	DS


