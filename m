Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUCPFw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbUCPFw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:52:57 -0500
Received: from studorgs.rutgers.edu ([128.6.24.131]:18590 "EHLO
	ruslug.rutgers.edu") by vger.kernel.org with ESMTP id S262862AbUCPFww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:52:52 -0500
Date: Tue, 16 Mar 2004 00:52:49 -0500
From: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
To: prism54-devel@prism54.org
Cc: netdev <netdev@oss.sgi.com>, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
Subject: Prism54 Driver Project Complete
Message-ID: <20040316055249.GE24063@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
Mail-Followup-To: prism54-devel@prism54.org,
	netdev <netdev@oss.sgi.com>, linux-kernel@vger.kernel.org,
	jgarzik@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Kernel.org bk2 was the first bk snapshot with prism54 driver in it.
bk4 is out already and some changes were already made too.=20
I was going to make some cvs repository changes today @ prism54.org
in order to attempt to keep a synced up repository for development=20
but I realize this is just not going to be possible. You can't stop=20
what goes on in the kernel tree and keeping our repository in-sync=20
with the latest bk snapshots is just too much pain in the ass to even=20
consider we'd be able to work out of a prism54 tree and write valid=20
patches.

At this point I think we can safely say the the prism54 project has=20
been complete. Although forced upon, this is not necessarily=20
a bad thing. The 2.6 prism54 driver is just going to take a life of=20
its own now and its out of our hands what goes on with it.

The 2.4 driver is still in our tree and not sure if it'll go into 2.4.
We'll see. Anyway for now the prism54.org project can still be home to furt=
her
advances of the driver/support. Please feel free to CC patches to us=20
(prism54-devel@prism54.org) for review in e-mails sent to netdev / Jeff / k=
ernel=20
mailing lists for peer review and updates. That's what we're now here for.=
=20
If you have other large prism54 contributions you can use prism54.org as yo=
ur home.

As for USB support maybe now we can put this as high priority while
other aspects of the driver are hammered by other developers. If you
will like to still follow up on the latest on prism54 development,
prism54.org will be the home for it. Just remember that it'd be just easier
for you to work out of kernel.org bk snapshots when writing patches
since we're no longer the home of the latest prism54 src.

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVpYxat1JN+IKUl4RApJiAJ4wQq5BksS3w6Ze1n/U1iPQnY2bCACcClKF
aarYK/hiG7/K/+37ZmeD7GI=
=WZGp
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
