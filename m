Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbTAGGyF>; Tue, 7 Jan 2003 01:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbTAGGyE>; Tue, 7 Jan 2003 01:54:04 -0500
Received: from h80ad273a.async.vt.edu ([128.173.39.58]:50561 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267513AbTAGGyD>; Tue, 7 Jan 2003 01:54:03 -0500
Message-Id: <200301070702.h0772UCR004666@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Lincoln Dale <ltd@cisco.com>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!) 
In-Reply-To: Your message of "Tue, 07 Jan 2003 17:45:03 +1100."
             <5.1.0.14.2.20030107174201.038ad1a8@mira-sjcm-3.cisco.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <20030107042045.GA10045@waste.org>
            <5.1.0.14.2.20030107174201.038ad1a8@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-769399486P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Jan 2003 02:02:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-769399486P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Jan 2003 17:45:03 +1100, Lincoln Dale said:
> At 12:38 AM 7/01/2003 -0500, Valdis.Kletnieks@vt.edu wrote:
> > > What was the underlying error rate and distribution you assumed? I
> > > figure if it were high enough to get to your 1%, you'd have such high
> > > retry rates (and resulting throughput loss) that the operator would
> > > notice his LAN was broken weeks before said transfer completed.
> >
> >The average ISP wouldn't notice things were broken unless enough magic
> >smoke escaped to cause a Halon dump.
> >
> >Consider as evidence the following NANOG presentation:
> >http://www.nanog.org/mtg-0210/wessels.html
> >
> >Some *98* percent of all queries at one of the root nameservers over a 24-ho
ur
> >period were broken in some way.
> 
> please don't confuse issues.
> i think you just epitomized the quote: "there are lies, damn lies, and 
> statistics".
> 
> you're trying to say that because there is some broken/buggy nameserver 
> code out there, it means that the error-rate for TCP is correct?

No, I'm saying the assertion that "the operator would notice his LAN was broken"
is incorrect.

--==_Exmh_-769399486P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+GnuFcC3lWbTT17ARAmO5AJ9cvv6jZX1UmiYKHJHTKff1BTLSSACg3Yth
WCYKCyRm+f5WU67QTPsihsk=
=2W+0
-----END PGP SIGNATURE-----

--==_Exmh_-769399486P--
