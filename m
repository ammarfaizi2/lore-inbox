Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTBQCRt>; Sun, 16 Feb 2003 21:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbTBQCRt>; Sun, 16 Feb 2003 21:17:49 -0500
Received: from clam.niwa.cri.nz ([202.36.29.1]:49929 "EHLO clam.niwa.co.nz")
	by vger.kernel.org with ESMTP id <S264925AbTBQCRs> convert rfc822-to-8bit;
	Sun, 16 Feb 2003 21:17:48 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andrej Ricnik <a.ricnik@niwa.co.nz>
Reply-To: a.ricnik@niwa.co.nz
Organization: niwa
To: linux-kernel@vger.kernel.org
Subject: Linux-Kernels 2.4.xx, apm & P4 issues
Date: Mon, 17 Feb 2003 15:27:10 +1300
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302171527.19066.a.ricnik@niwa.cri.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi Guys,

and my apologies for the general direction.

I have googled on this topic, asked on discussion boards
and couldn't find any suitable hints.

The problem that I encounter is happening on a mobile P4.
When apm is active (I've compiled it as a module in
both a 2.4.18 and 2.4.20 kernel) my system clock errs
by as much as 90 seconds in an hour. Also, I seem to
experience keyboard related problems (Ctrl, Alt, Shift get
*sticky* -excuse my wording, I can't think of a better 
description- that is, if I press them while typing normally,
even though they are released physically their functionality
carries on. Also the cursor keys sometimes issue numbers rather
than cursor-movement) when apm is running.

The machine in question is a IBM Thinkpad R32, mobile P4 1.8GHz,
512MB RAM.

I'm running Slackware Linux 8.1 with stock kernels.
Note that the identical setup worked flawless on my
previous notebook, a PII 266, same brand (TP770ED)
and that according to IBM (I sent the box in for service
because I couldn't test whether it works with XP because
I wiped it) the machine has no problems in Windows.

- -- 
Cheers,
Andrej Ricnik (programmer, fisheries acoustics)

P.S.: Please find attached output from my proc-filesystem
that might be relevant to the problem.



NIWA (National Institute of Water & Atmospheric Research Ltd)
PO Box 14 901, Kilbirnie, Wellington, New Zealand
Phone: ++64 4 386 0300
Fax: ++ 64 4 386 0574

- --------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------
Standard-footer:
If you have a spare minute: http://expita.com/nomime.html

Disclaimer:
This, however, just expresses my personal opinion on that
topic and is not part of NIWA's policy :}
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+UEiGjFwoFqHsVFwRAvEiAKCxJj5AiPHjtM8xnmHpDMqlKIZkxgCeOK0V
ppne6fvQ2Q/QG0v01l1GCFM=
=1Es7
-----END PGP SIGNATURE-----

