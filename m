Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTLPONO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 09:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLPONO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 09:13:14 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:37038 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261827AbTLPONN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 09:13:13 -0500
Date: Tue, 16 Dec 2003 15:13:06 +0100
From: Martin Waitz <tali@admingilde.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: request: capabilities that allow users to drop privileges further
Message-ID: <20031216141306.GB1117@admingilde.org>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20031215213912.GA29281@codeblau.de> <20031215144809.A14552@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z83JOb+Pp/DrQW9p"
Content-Disposition: inline
In-Reply-To: <20031215144809.A14552@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Z83JOb+Pp/DrQW9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Dec 15, 2003 at 02:48:09PM -0800, Chris Wright wrote:
> >   * ptrace
>=20
> drop CAP_SYS_PTRACE
that will only help agains ptracing foreign processes.
you can still debug your own ones.

so this does not help agains buffer overflows&co in ptrace


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--Z83JOb+Pp/DrQW9p
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/3xLxj/Eaxd/oD7IRAt+bAJ9S5lGllph8uz/HxPyokktKp2IsfgCePfL5
QD7h8fVZxLRHf2x+z7QlqPs=
=vet7
-----END PGP SIGNATURE-----

--Z83JOb+Pp/DrQW9p--
