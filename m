Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266855AbUHSR37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUHSR37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUHSR37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:29:59 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:16285 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266849AbUHSR35
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:29:57 -0400
Date: Thu, 19 Aug 2004 19:28:46 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Olaf Hering <olh@suse.de>, ismail d?nmez <ismail.donmez@gmail.com>,
       Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Message-ID: <20040819172846.GA15361@thundrix.ch>
References: <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com> <41225D16.2050702@microgate.com> <2a4f155d040817124335766947@mail.gmail.com> <41226512.9000405@microgate.com> <20040818062210.GB22332@suse.de> <2a4f155d040817233463d2b78d@mail.gmail.com> <20040818064229.GD22332@suse.de> <1092855516.8998.34.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <1092855516.8998.34.camel@nosferatu.lan>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Saut,

On Wed, Aug 18, 2004 at 08:58:37PM +0200, Martin Schlemmer wrote:
> Ismail, what tries to use /dev/tty anyhow?

It's  the standard  UN*X way  of  finding your  controlling TTY:  open
/dev/tty and  do an  isatty on it.  So I'd  suppose around 90%  of the
console software does that.

			Tonnerre

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBJONN/4bL7ovhw40RAjqOAJ9yZeNPYL7ddu4Ba91P8grP2EZiuQCfa4Am
RGUTwhxXuK6cCS50Masoz0s=
=4CEr
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
