Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTAFV5e>; Mon, 6 Jan 2003 16:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbTAFV5d>; Mon, 6 Jan 2003 16:57:33 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23170 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267227AbTAFV5c>; Mon, 6 Jan 2003 16:57:32 -0500
Message-Id: <200301062206.h06M61H2008609@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Ranjeet Shetye <ranjeet.shetye@zultys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers? 
In-Reply-To: Your message of "Mon, 06 Jan 2003 13:05:59 PST."
             <015401c2b5c7$6a088da0$0100a8c0@zultys.com> 
From: Valdis.Kletnieks@vt.edu
References: <015401c2b5c7$6a088da0$0100a8c0@zultys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-575010893P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Jan 2003 17:06:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-575010893P
Content-Type: text/plain; charset=us-ascii

On Mon, 06 Jan 2003 13:05:59 PST, Ranjeet Shetye <ranjeet.shetye@zultys.com>  said:

> MS might have their names in the RFCs; doesn't mean that they really
> contribute positively to the community.

In addition, there's some slanted statistics being done here by Hedding....

> > From: linux-kernel-owner@vger.kernel.org 
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> > Henning P. Schmiedehausen
> > Sent: Sunday, January 05, 2003 12:41 PM

> > % cd /home/mirror/RFC
> > % for i in rfc*.txt; do head -20 $i | grep -iq microsoft; if 
> > [ "x$?" = "x0" ]; then    echo $i; fi; done | wc -l
> >     102     102    1224 /tmp/rfc-log
> > % for i in rfc*.txt; do head -20 $i | grep -iq 'red hat'; if 
> > [ "x$?" = "x0" ]; then    echo $i; fi; done | wc -l
> > % for i in rfc*.txt; do head -20 $i | grep -iq 'redhat'; if [ 
> > "x$?" = "x0" ]; then    echo $i; fi; done | wc -l

Hmm.. Zorn is an author 20 times, Aboba 16 (usually with Zorn), Huitema 15.

And of those 102, at least 8 are documenting Microsoft-specific things like its
CHAP and Kerberos extensions. So leave them out of the count, and we see that
just 2-3 guys are a third of it right there.  And Microsoft employs how many
people?  That's some *HUGE* dent in their manpower supply....

Meanwhile, looking in the MAINTAINERS file, I see 343 M: tags, of which
only 12 are redhat.com addresses (and only 7 unique ones at that). And
Redhat isn't primarily a development company, they're a packaging company.
The vast amount of Linux development would be elsewhere - it would be
fairer to compare RedHat's RFC output with the RFC output of Microsoft's
packaging and shipping department.....

Now how many RFC's has Ted T'so  written? And how much has he done for Linux?
Of course, he doesn't use a redhat.com address, so he doesn't count...

Naughty thing, those statistics - people keep trying to misuse them. ;)
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-575010893P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Gf3JcC3lWbTT17ARApjTAKDrc4eLeVCSJxQ+rfZfM/zqDX+SdQCgvwaF
vvZZ+SFmeeAEBYlHAYhP2mU=
=9mFe
-----END PGP SIGNATURE-----

--==_Exmh_-575010893P--
