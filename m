Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264273AbUD0Syt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbUD0Syt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUD0Syt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:54:49 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:24451 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264273AbUD0Syr (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:54:47 -0400
Message-Id: <200404271854.i3RIsdaP017849@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license 
In-Reply-To: Your message of "Tue, 27 Apr 2004 19:53:39 +0200."
             <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net> 
From: Valdis.Kletnieks@vt.edu
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com>
            <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2022339474P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Apr 2004 14:54:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2022339474P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Apr 2004 19:53:39 +0200, Grzegorz Kulewski said:

> Maybe kernel should display warning only once per given licence or even 
> once per boot (who needs warning about tainting tainted kernel?)

If your kernel is tainted by 3 different modules, it saves you 2 reboots when
trying to replicate a problem with an untainted kernel.

Other than that, there's probably no reason to complain on a re-taint.


--==_Exmh_-2022339474P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAjqxucC3lWbTT17ARAkNLAJ4kejfd45L6yUXHnTN4zbT8+GuIMQCg+TTd
hz4eKL5f0nqGdA3Rhdouygg=
=H1ps
-----END PGP SIGNATURE-----

--==_Exmh_-2022339474P--
