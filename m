Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276057AbRJPMMU>; Tue, 16 Oct 2001 08:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276060AbRJPMMK>; Tue, 16 Oct 2001 08:12:10 -0400
Received: from stingr.net ([212.193.33.37]:59908 "HELO stingray.sgu.ru")
	by vger.kernel.org with SMTP id <S276057AbRJPMMB>;
	Tue, 16 Oct 2001 08:12:01 -0400
Date: Tue, 16 Oct 2001 16:12:09 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: P4 problems
Message-ID: <20011016161209.A6038@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BCC0A5B.846C20E8@psimation.com> <23891.1003232529@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23891.1003232529@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Tue, Oct 16, 2001 at 09:42:09PM +1000
User-Agent: Agent Orange
X-Mailer: mIRC32 v5.91 K.Mardam-Bey
X-RealName: Stingray Greatest Jr
Organization: Stingray Software
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Replying to Keith Owens:
> If nobody can point to a known bug, try this to localize the problem.

I think this is a well-known bug. In apic init, we got cpu frequency xxxx.yy
mhz, then bus frequency 0.000
then we hang

:)

( don't know solution - just get rid of these p4 ... for now. maybe later )
- -- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
-----BEGIN PGP SIGNATURE-----

iEYEAREDAAYFAjvMJBUACgkQyMW8naS07KTMMwCff6bu3OsFNhvRpHWzl2enIQMN
issAn2qa71tBd86PVd47yEmY7YgS8zHa
=GJZ4
-----END PGP SIGNATURE-----
