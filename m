Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTDWRAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264133AbTDWRAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:00:34 -0400
Received: from dracula.eas.gatech.edu ([130.207.67.209]:49370 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S264132AbTDWRAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:00:32 -0400
Date: Wed, 23 Apr 2003 13:10:36 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5.68] [BUG #18] Add Synaptics touchpad tweaking to psmouse driver
Message-ID: <20030423171036.GA6618@shaftnet.org>
References: <20030422024628.GA8906@shaftnet.org> <20030423170336.GL1202@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20030423170336.GL1202@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2003 at 03:03:36AM +1000, CaT wrote:
> I haven't tested it mainly because it doesn't do anything useful for me
> yet (and, infact, reduces usability) but I'll be more then happy to test
> any future more general patches that you may come up with.

Um, it doesn't reduce functionality.  There's a module parameter to=20
enable/disable the tap-to-click.  :)

Any further functionality will require a much older touchpad (rev <4),=20
and/or the use of absolute mode.  But I'm working on that.

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
                                                           ICQ #1318444
Quidquid latine dictum sit, altum viditur                 Melbourne, FL

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+pskLPuLgii2759ARAmA9AJ9LW7UltMIAtsEVEJmM/fKVVYINlgCgqU6d
6ncoL5gB3tFJKZvydB9Jzmo=
=GsFi
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
