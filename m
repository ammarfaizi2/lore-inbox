Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTFJPxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTFJPxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:53:49 -0400
Received: from iucha.net ([209.98.146.184]:36144 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263277AbTFJPwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:52:18 -0400
Date: Tue, 10 Jun 2003 11:05:59 -0500
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: about bdflush
Message-ID: <20030610160559.GE6757@iucha.net>
Mail-Followup-To: Michael Zhu <mylinuxk@yahoo.ca>,
	linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <20030610155532.35065.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <20030610155532.35065.qmail@web14914.mail.yahoo.com>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2003 at 11:55:32AM -0400, Michael Zhu wrote:
> Hi, guys, I have a small question about
> /proc/sys/vm/bdflush . I am working on a SMP machine.
> The kernel version is 2.4.18. I want to modify the
> content of /proc/sys/vm/bdflush. But once I modify the
> content, it will go back to the default value after I
> reboot the OS. Is there a way by which I can
> permanently change the content of this file? The OS
> keeps the default value in somewhere?=20

Set the value in an init script.

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5gHnNLPgdTuQ3+QRAsMvAKCV98zR+qBigLWQ8kgZOy7dPDktDQCdHxdH
m+vXgoj2/+WzkJXsbh66Fes=
=ZVj6
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
