Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBOM2t>; Thu, 15 Feb 2001 07:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129276AbRBOM2j>; Thu, 15 Feb 2001 07:28:39 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:50183 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129075AbRBOM2S>; Thu, 15 Feb 2001 07:28:18 -0500
Date: Thu, 15 Feb 2001 12:28:10 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netmos PCI parallel card
Message-ID: <20010215122810.W9459@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0102151149240.30393-300000@jdi.jdimedia.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Vmb+IyT2VBRvgrJP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102151149240.30393-300000@jdi.jdimedia.nl>; from i.palsenberg@jdimedia.nl on Thu, Feb 15, 2001 at 11:52:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Vmb+IyT2VBRvgrJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2001 at 11:52:46AM +0100, Igmar Palsenberg wrote:

> Attached is a patch to make a Netmos PCI parallal port card working.

Please try the following patch instead.  That card _should_ have a
working ECR.

<URL:ftp://people.redhat.com/twaugh/patches/linux24/linux-netmos.patch>

Tim.
*/

--Vmb+IyT2VBRvgrJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6i8tYONXnILZ4yVIRAshRAJ48magS7k2tH8PDX2uWVPqN6EXx2gCfdoQI
X1wt+cTqSjc/nVS0A8Ilk9E=
=qugK
-----END PGP SIGNATURE-----

--Vmb+IyT2VBRvgrJP--
