Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbTAJPhg>; Fri, 10 Jan 2003 10:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTAJPhg>; Fri, 10 Jan 2003 10:37:36 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:31360 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265369AbTAJPhf>; Fri, 10 Jan 2003 10:37:35 -0500
Message-Id: <200301101544.h0AFiBLK009357@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Harry Sileoni <stamina@kolumbus.fi>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion 
In-Reply-To: Your message of "Fri, 10 Jan 2003 14:12:53 +0100."
             <15902.50901.407336.44434@harpo.it.uu.se> 
From: Valdis.Kletnieks@vt.edu
References: <1042203152.954.7.camel@vihta>
            <15902.50901.407336.44434@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-432089335P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jan 2003 10:44:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-432089335P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jan 2003 14:12:53 +0100, Mikael Pettersson said:
> Harry Sileoni writes:
>  > While fighting for some time with my Dell Inspiron 8100 laptop and a new

> Are you sure you didn't mean ACPI instead? APIC != ACPI but
> people keep confusing the two.

The Dell Latitude C840 (what I have) and the (AFAIK) Inspiron 8100 both use
the NVidia geForce4 Go graphics chipset, and apparently the posted patches
to make nvidia's closed-source drivers work under 2.5 have issues with ACPI
on some platforms.  Digging back, I only found like one message on the LKML
archives that mentioned the nvidia drivers don't play nice with ACPI.

Harry - does that match up with what you have?
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-432089335P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+HupLcC3lWbTT17ARAu2qAJ96Jn+u+LLJrSVE6kZTN4t0rrarMQCfQqgp
9phOKaLQVRKL+k3meveWr+U=
=ew8M
-----END PGP SIGNATURE-----

--==_Exmh_-432089335P--
