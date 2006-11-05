Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWKEROe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWKEROe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWKEROe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:14:34 -0500
Received: from nsm.pl ([195.34.211.229]:2236 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1161374AbWKEROd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:14:33 -0500
Date: Sun, 5 Nov 2006 18:14:24 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kvm howto
Message-ID: <20061105171424.GA7045@irc.pl>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <4549F1D5.8070509@qumranet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <4549F1D5.8070509@qumranet.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2006 at 03:25:41PM +0200, Avi Kivity wrote:
> I've just uploaded a HOWTO to http://kvm.sourceforge.net, including=20
> (hopefuly) everything needed to get kvm running.  Please take a look and=
=20
> comment.

  I have some problems on Thinkpad z61t with Core Duo T2500.
/proc/cpuinfo shows "vmx" in flags, but module refuses to load:
[17462106.632000] kvm: disabled by bios

 I wandered around BIOS setup (latest version), but didn't found
anything about virtualization. Is BIOS check really necessary?

--=20
Tomasz Torcz                                                       72->|   =
80->|
zdzichu@irc.-nie.spam-.pl                                          72->|   =
80->|


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFFThvw10UJr+75NrkRAsdUAJ91Gh5E1NC0SKnJHE/ZM0kZOjukeACfb1r6
R3gOqcsbztIrC9QHgIoQuBE=
=ArCM
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
