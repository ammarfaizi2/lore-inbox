Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282419AbRKZT2n>; Mon, 26 Nov 2001 14:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282411AbRKZT1Y>; Mon, 26 Nov 2001 14:27:24 -0500
Received: from dozer.billjonas.com ([207.106.130.91]:62473 "EHLO
	dozer.billjonas.com") by vger.kernel.org with ESMTP
	id <S282040AbRKZT0N>; Mon, 26 Nov 2001 14:26:13 -0500
Date: Mon, 26 Nov 2001 14:23:02 -0500
From: Bill Jonas <bill@billjonas.com>
To: linux-kernel@vger.kernel.org
Subject: [OT] Re: Loopback sound driver?
Message-ID: <20011126142301.U17545@billjonas.com>
In-Reply-To: <200111261902.fAQJ27U09373@ambassador.mathewson.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YzdYn+D7cUqe+VA3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111261902.fAQJ27U09373@ambassador.mathewson.int>; from joe@mathewson.co.uk on Mon, Nov 26, 2001 at 07:02:06PM -0000
X-Ambivalence: Maybe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YzdYn+D7cUqe+VA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2001 at 07:02:06PM -0000, Joseph Mathewson wrote:
> Has anyone yet written a loopback sound driver, that is a module that
> provides a "fake" /dev/dsp that will actually save sound to file on
> disk rather than playing thru a hardware sound card.

No need for kernel support.  Check out vsound.  (Requires sox.)  On
Debian, "apt-get install vsound".

http://www.zip.com.au/~erikd/vsound/

--=20
Bill Jonas    *    bill@billjonas.com    *    http://www.billjonas.com/

Developer/SysAdmin for hire!   See http://www.billjonas.com/resume.html

--YzdYn+D7cUqe+VA3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ApaVdmHcUxFvDL0RAhVZAKCKPOuTfDz7oIBpLIsU8NRbeeofsACePl+v
gA8z78RWmdMQul8EdbwWNC0=
=sJwH
-----END PGP SIGNATURE-----

--YzdYn+D7cUqe+VA3--
