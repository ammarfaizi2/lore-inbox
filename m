Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTBQBzI>; Sun, 16 Feb 2003 20:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTBQBzH>; Sun, 16 Feb 2003 20:55:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64018 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S263291AbTBQBzH>; Sun, 16 Feb 2003 20:55:07 -0500
Date: Sun, 16 Feb 2003 20:59:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.60-mm2
In-Reply-To: <200302141110.49348.schlicht@uni-mannheim.de>
Message-ID: <Pine.LNX.3.96.1030216205709.29049B-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; PROTOCOL="application/pgp-signature"; MICALG=pgp-sha1; BOUNDARY="Boundary-02=_pCMT+DYGeShQy4x"; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.3.96.1030216205709.29049C@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary-02=_pCMT+DYGeShQy4x
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.3.96.1030216205709.29049D@gatekeeper.tmr.com>
Content-Description: signed data

On Fri, 14 Feb 2003, Thomas Schlichter wrote:


> I've got NFS problems with 2.5.5x - 60-bk3, too, but here I can workaround 
> them by simply pinging the NFS-server every second... Funny, but it works!
> Perhaps this can help finding the real bug?!

I was looking for network issues when I started timing pings, and didn't
see any. I thought it was bad timing, link not raining when you have a
coat, but maybe I was curing it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--Boundary-02=_pCMT+DYGeShQy4x
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1030216205709.29049E@gatekeeper.tmr.com>
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+TMCpYAiN+WRIZzQRAkV8AJwKY8v7t1jvBMFbyNXaFt1c5QzKbQCdFcXB
/KQsXPQPTki+B5HzH3QsQZc=
=PNko
-----END PGP SIGNATURE-----

--Boundary-02=_pCMT+DYGeShQy4x--
