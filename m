Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSKODtp>; Thu, 14 Nov 2002 22:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbSKODtp>; Thu, 14 Nov 2002 22:49:45 -0500
Received: from mta03ps.bigpond.com ([144.135.25.135]:55521 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S265700AbSKODtm>; Thu, 14 Nov 2002 22:49:42 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Thomas Molina <tmolina@cox.net>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Date: Fri, 15 Nov 2002 14:46:44 +1100
User-Agent: KMail/1.4.5
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211142132500.2229-100000@dad.molina>
In-Reply-To: <Pine.LNX.4.44.0211142132500.2229-100000@dad.molina>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211151446.44969.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 15 Nov 2002 14:43, Thomas Molina wrote:
> My question is how should compile failures figure into the bug database?
> Most of the compile failures are typos or thinkos that get quickly fixed.
> Should they get tracked, or dismissed quickly unless they linger on.  I
> didn't track simple compile failures in my list.
It probably depends where in the 2.5 cycle you are up to. 

While there are still a lot of changes going in, it isn't so critical.

When it gets to 2.5.99 and later, you need to track absolutely everything. 
Even if that means entering the problem, and 20 minutes later entering the 
patch that corrects it, and the next day closing the bug against Linus' next 
release. 

Given a resourced bug tracker, and the various test projects, this could be a 
nice smooth release producing a product without gaping holes. But its 
probably a bit soon to tell...

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE91G4kW6pHgIdAuOMRAkNiAKCNE7pvodft5ZC+e7nTqgbLeLO0ewCfQujm
bNoeJoLIea10YFPSTfyRdnM=
=SPCi
-----END PGP SIGNATURE-----

