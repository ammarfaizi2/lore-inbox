Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRIDIut>; Tue, 4 Sep 2001 04:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271915AbRIDIuk>; Tue, 4 Sep 2001 04:50:40 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:60940 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271911AbRIDIub>; Tue, 4 Sep 2001 04:50:31 -0400
Date: Tue, 4 Sep 2001 09:50:42 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Patrick Dreker <patrick@dreker.de>
Cc: Michael Ben-Gershon <mybg@netvision.net.il>, linux-kernel@vger.kernel.org
Subject: Re: lpr to HP laserjet stalls
Message-ID: <20010904095042.N20060@redhat.com>
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com> <E15e4WO-0007uH-00@wintermute>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ehgLApe97pcc1Rh5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15e4WO-0007uH-00@wintermute>; from patrick@dreker.de on Tue, Sep 04, 2001 at 02:56:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ehgLApe97pcc1Rh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2001 at 02:56:56AM +0200, Patrick Dreker wrote:

> All of this vanished, when I replaced all occurrences of /dev/lp0 in my=
=20
> printer configuration by /dev/par0. I has been working flawlessly since t=
hen.

crw-rw----    1 root     lp         6,   0 Aug 30 21:30 /dev/lp0
crw-------    1 root     root       6,   0 Aug 30 21:30 /dev/par0

Are you sure you didn't also upgrade the kernel? ;-)

Tim.
*/

--ehgLApe97pcc1Rh5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7lJXhONXnILZ4yVIRApdaAKCrDEMy8MxaEpBCcWcgcbpVzreyAACgpXJe
0fgItE7YsjYZVU8ZSxyMwmw=
=rzI3
-----END PGP SIGNATURE-----

--ehgLApe97pcc1Rh5--
