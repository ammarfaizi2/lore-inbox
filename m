Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288930AbSA2OeW>; Tue, 29 Jan 2002 09:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289385AbSA2OeM>; Tue, 29 Jan 2002 09:34:12 -0500
Received: from out018pub.verizon.net ([206.46.170.96]:44983 "EHLO
	out018.verizon.net") by vger.kernel.org with ESMTP
	id <S288930AbSA2OeA>; Tue, 29 Jan 2002 09:34:00 -0500
Date: Tue, 29 Jan 2002 09:30:59 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <a354iv$ai9$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a354iv$ai9$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 29, 2002 at 03:23:11AM +0000
Message-Id: <20020129143359.BBSA15035.out018.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
[snip]
> A word of warning: good maintainers are hard to find.  Getting more of
> them helps, but at some point it can actually be more useful to help the
> _existing_ ones.  I've got about ten-twenty people I really trust, and

Then why not give the subsystem maintainers patch permissions on your tree.
Sort of like committers.  The problem people have is that you're dropping
patches from those ten-twenty people you trust.

Each subsystem maintainer should handle patches to that subsystem, and
you should remove your own patch permissions for only those subsystems.
You could get involved with only changes in direction that affect more
than one subsystem.

> quite frankly, the way people work is hardcoded in our DNA.  Nobody
> "really trusts" hundreds of people.  The way to make these things scale
> out more is to increase the network of trust not by trying to push it on
> me, but by making it more of a _network_, not a star-topology around me. 
> 
> In short: don't try to come up with a "patch penguin".  Instead try to
> help existing maintainers, or maybe help grow new ones. THAT is the way
> to scalability.

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjxWsfkACgkQBMKxVH7d2wpAfQCfRMoMirEH2/KRYMowNkZyMCBi
CEYAoM4akKt8Ifl20cvkA5UG8Kb4p9Tb
=q5bM
-----END PGP SIGNATURE-----
