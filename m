Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRCFS2X>; Tue, 6 Mar 2001 13:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbRCFS2N>; Tue, 6 Mar 2001 13:28:13 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:21004 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129115AbRCFS2C>; Tue, 6 Mar 2001 13:28:02 -0500
Date: Tue, 6 Mar 2001 19:26:36 +0100
From: Kurt Garloff <garloff@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Patch submissions
Message-ID: <20010306192636.G5944@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E14aKlG-00011U-00@the-village.bc.nu> <Pine.LNX.4.33.0103061422030.1409-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="VkqCAaSJIySsbD6j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103061422030.1409-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Mar 06, 2001 at 02:22:58PM -0300
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VkqCAaSJIySsbD6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2001 at 02:22:58PM -0300, Rik van Riel wrote:
> I agree with Alan that we should keep all experimental stuff
> out of 2.4,

Depends on the impact. Experimental stuff in MM, FS, ... things is something
which we don't want. If somebody writes a new driver for a device which was
not supported before, we may want to add it to the kernel to get it tested
and improved.
But, that's probably what you meant.

> probably even out of linux-kernel ...

No. I want to see experimental stuff on l-k. That's what it's meant for.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--VkqCAaSJIySsbD6j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6pSvbxmLh6hyYd04RArJIAJsGsLCVeXE5cunT10vhnaTUFZbrFgCgjIiK
ubsQpe7OFz4fLoXrrFhMUVs=
=Vsu1
-----END PGP SIGNATURE-----

--VkqCAaSJIySsbD6j--
