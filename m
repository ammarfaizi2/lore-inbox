Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHw4HX3Fey3xTN24o5XSoS8hHQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 16:02:08 +0000
Message-ID: <01f301c415a4$7c382290$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:42:47 +0100
From: "Ciaran McCreesh" <ciaranm@gentoo.org>
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M config option for 2.6
In-Reply-To: <20040104144350.GD24913@louise.pinerecords.com>
References: <200401041410.i04EA61e007769@harpo.it.uu.se><20040104144350.GD24913@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Signature=_Sun__4_Jan_2004_15_59_41_+0000_.cWKGb=mK4TKqteu"
X-OriginalArrivalTime: 04 Jan 2004 16:00:11.0290 (UTC) FILETIME=[D53077A0:01C3D2DB]
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Signature=_Sun__4_Jan_2004_15_59_41_+0000_.cWKGb=mK4TKqteu
Content-Type: text/plain;
	charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 4 Jan 2004 15:43:50 +0100 Tomas Szepe <szepe@pinerecords.com>
wrote:
| +config MPENTIUMM
| +	bool "Pentium M (Banias/Centrino)"
| +	help
| +	  Select this for Intel Pentium M chips.  This option enables
| +	  compile flags optimized for the chip, uses the correct cache
| +	  shift, and applies any applicable Pentium III/IV

That should probably read "Pentium III/4".

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm


--Signature=_Sun__4_Jan_2004_15_59_41_+0000_.cWKGb=mK4TKqteu
Content-Transfer-Encoding: 7bit
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+Dh396zL6DUtXhERAnAeAJ9sF2hG1DDXr+wDUm3Tg4oZYEH2MQCfemTD
PrlS+9B83yCA5wVLmfTi4jU=
=X9PQ
-----END PGP SIGNATURE-----

--Signature=_Sun__4_Jan_2004_15_59_41_+0000_.cWKGb=mK4TKqteu--
