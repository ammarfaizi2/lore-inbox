Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318432AbSGSDRQ>; Thu, 18 Jul 2002 23:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318433AbSGSDRQ>; Thu, 18 Jul 2002 23:17:16 -0400
Received: from dsl-65-189-106-249.telocity.com ([65.189.106.249]:49291 "EHLO
	mail.temp123.org") by vger.kernel.org with ESMTP id <S318432AbSGSDRQ>;
	Thu, 18 Jul 2002 23:17:16 -0400
Date: Thu, 18 Jul 2002 23:20:08 -0400
From: Josh Litherland <fauxpas@temp123.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keypad
Message-ID: <20020719032008.GA22934@temp123.org>
References: <20020719015232.GA20956@temp123.org> <20020719031000.GA18382@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20020719031000.GA18382@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2002 at 08:10:00PM -0700, Greg KH wrote:

> Should work just fine today.  What kind of problems do you have when you
> try to do it?

Just not getting any events from the keypad.  When I load up evdev, and
cat the device I get the appropriate gibberish, so the device is
detected okay.  This is 2.4.18, if that makes a difference for the
purposes of this discussion.

--=20
Josh Litherland (fauxpas@temp123.org)
public key: temp123.org/fauxpas.pgp
fingerprint: CFF3 EB2B 4451 DC3C A053  1E07 06B4 C3FC 893D 9228

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj03hWgACgkQBrTD/Ik9kiiYWACgqVagUYM5G1hVSI3HVnaovFVK
IX8Ani0SFHt3LuZGlqUOxri8xYZe2Ggq
=Ae+t
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
