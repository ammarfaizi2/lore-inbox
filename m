Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbRCCWZ1>; Sat, 3 Mar 2001 17:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129820AbRCCWZS>; Sat, 3 Mar 2001 17:25:18 -0500
Received: from twin.uoregon.edu ([128.223.214.27]:53416 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S129819AbRCCWZK>;
	Sat, 3 Mar 2001 17:25:10 -0500
Date: Sat, 3 Mar 2001 14:24:57 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
To: Jon Masters <jonathan@jonmasters.org>
cc: Jeremy Jackson <jerj@coplanar.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Forwarding broadcast traffic
In-Reply-To: <3AA138A1.72E99C7C@jonmasters.org>
Message-ID: <Pine.LNX.4.30.0103031421350.30684-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to selectively bridge broadcast traffic in the way I have
> described?

Take a look at how your router handles broadcast dhcp requests cisco at
least have a dhcp helper functionality which is essentially just what
you're asking for (selective forwarding of broadcast traffic.

if you really want to do this in a standard fashion though it sounds like
an application for multicast...

joelja

> Normally of course I'd have the router either being a standard router or
> a bridge but in this case some kind of hybrid arrangement would be
> preferable.
>
> Thanks for your help,
> 			--jcm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


