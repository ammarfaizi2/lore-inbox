Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTJUTph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTJUTph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:45:37 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:61596 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S263280AbTJUTpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:45:35 -0400
Date: Tue, 21 Oct 2003 21:44:50 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8-bk1 apm -s with synaptics won't work
Message-ID: <20031021194449.GA2773@puettmann.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1AC2R0-0000jL-00*T4Ukisn.c.g* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


        hello,

Thinkpad R40 2722-GDG/D=20
Kernel: 2.6.0-test8-bk1

on apm -s :


psmouse.c: Failed to enable mouse on synaptics-pt/serio0

After this message no apm -s or apm -S will work and=20
on interrupt on touchpad will return :

"Synaptics driver lost sync at 1st byte"


        Ruben


--=20
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lYyxgHHssbUmOEIRAumYAJ9h/OgCVlL2o7Tto920M52DfjDu3ACdEHO0
NjqKEsP+xlOZ97TEXlkyLZ4=
=kia9
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
