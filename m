Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTAaObP>; Fri, 31 Jan 2003 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTAaObP>; Fri, 31 Jan 2003 09:31:15 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35968 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261290AbTAaObO>; Fri, 31 Jan 2003 09:31:14 -0500
Message-Id: <200301311440.h0VEeRlH005883@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 morse code panics 
In-Reply-To: Your message of "Fri, 31 Jan 2003 13:22:21 GMT."
             <20030131132221.GA12834@codemonkey.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20030131104326.GF12286@louise.pinerecords.com> <200301311112.h0VBCv00000575@darkstar.example.net>
            <20030131132221.GA12834@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_492673070P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 31 Jan 2003 09:40:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_492673070P
Content-Type: text/plain; charset=us-ascii

On Fri, 31 Jan 2003 13:22:21 GMT, Dave Jones said:

> Or you could put down the crackpipe and run a serial console between
> the two boxes. Or even netconsole would make more sense
> (and be a lot more reliable).

There's a classic Monty Python skit where John Cleese is organizing an
expedition to build a bridge between the two peaks of Mt Kilamanjaro.

I have to do most of my kernel hacking at home, on my own time.  So I'm
sitting there with a laptop and no second machine.  Now, if the intent is
to say "Don't bother doing anything that might require debugging unless you
can afford 2 machines", that's OK - but let's be open about that requirement.
And has been pointed out, some laptops don't even *HAVE* a serial port.

There's a *REASON* that IBM RS/6K boxes have at least a little 3-digit LED
display - during boot or a panic, even if you can't trust the console drivers
anymore, you can still output *something*.

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_492673070P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+OoracC3lWbTT17ARAjATAKCq5hqmQX6HV+ElYCXjrFfU7jweDQCg05Uk
66IJyVUcATfQu0czukDtOfs=
=nTQj
-----END PGP SIGNATURE-----

--==_Exmh_492673070P--
