Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135317AbRAGADN>; Sat, 6 Jan 2001 19:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135306AbRAGADE>; Sat, 6 Jan 2001 19:03:04 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:3070 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S135271AbRAGACu>; Sat, 6 Jan 2001 19:02:50 -0500
Date: Sun, 7 Jan 2001 00:02:48 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: SCSI scanner problem with all kernels since 2.3.42
Message-ID: <20010107000248.A11494@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm having problems with using xsane to acquire a preview from an HP
ScanJet 5P connected to an AHA-2940.  2.3.42 is the last kernel that
works right for me.

The symptom is that the scanner starts to make scanning sounds, then
stops, and xsane says 'Error during read: Error during device I/O'.

Any ideas?

Tim.
*/

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6V7ImONXnILZ4yVIRAl+gAJ9GWUmO5uTQU9FSEF132Q8wFyjCJQCgnX3x
RP4IpgNRO6Iy0mSdywZIgZU=
=tfhg
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
