Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132743AbRDINXg>; Mon, 9 Apr 2001 09:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132746AbRDINX0>; Mon, 9 Apr 2001 09:23:26 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:48503 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132743AbRDINXK>; Mon, 9 Apr 2001 09:23:10 -0400
Date: Mon, 9 Apr 2001 14:23:04 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jakob Kemi <jakob.kemi@post.utfors.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20010409142304.H1136@redhat.com>
In-Reply-To: <3.0.1.32.20010402212043.00dadd18@post.utfors.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="QDd5rp1wjxlDmy9q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3.0.1.32.20010402212043.00dadd18@post.utfors.se>; from jakob.kemi@post.utfors.se on Mon, Apr 02, 2001 at 09:20:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QDd5rp1wjxlDmy9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 02, 2001 at 09:20:43PM +0200, Jakob Kemi wrote:

> Ok, maybe this isn't the right list for this question. In 2.2.x the
> parport_probe module extracted the ieee1284 device id correctly and
> added to the proc fs. However this doesn't seem to work for me in
> 2.4.x

It changed place: perhaps that's the problem?  /proc/parport/$n is now
/proc/sys/dev/parport/$name.

> Is there some option I need to enable. As far as I understand the
>  CONFIG_PARPORT_1284 should be enough??

Yes, it should.

Tim.
*/

--QDd5rp1wjxlDmy9q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE60be4ONXnILZ4yVIRAvFSAJ9r9+t8auFaSs7I8100A8R18M7QagCgmN17
QJQPUkHUnnFS8e6tgR3fBd0=
=eDcm
-----END PGP SIGNATURE-----

--QDd5rp1wjxlDmy9q--
