Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289738AbSAXDQ7>; Wed, 23 Jan 2002 22:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289874AbSAXDQu>; Wed, 23 Jan 2002 22:16:50 -0500
Received: from hydra.acs.uci.edu ([128.200.16.3]:39089 "EHLO hydra.acs.uci.edu")
	by vger.kernel.org with ESMTP id <S289738AbSAXDQg>;
	Wed, 23 Jan 2002 22:16:36 -0500
Date: Wed, 23 Jan 2002 19:16:34 -0800
From: Richard Massa <rmassa@hydra.acs.uci.edu>
To: "Punj, Arun" <Arun.Punj@marconi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: NEWBIE : can't find /lib/modules/2.4.17/modules.dep error
Message-ID: <20020123191634.J31984@smaug.acs.uci.edu>
In-Reply-To: <313680C9A886D511A06000204840E1CF40B60A@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="RUqJLqMNe5u4kDWT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <313680C9A886D511A06000204840E1CF40B60A@whq-msgusr-02.pit.comms.marconi.com>; from Arun.Punj@marconi.com on Wed, Jan 23, 2002 at 06:35:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RUqJLqMNe5u4kDWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

You need to make modules and make modules_install too :)

On Wed, Jan 23, 2002 at 06:35:47PM -0500, Punj, Arun wrote:
>=20
> Folks,
>=20
> I upgraded the 2.4.7-10 kernel that comes with RH7.2 to 2.4.17.=20
> [ I could compile it fine and grub is able to load it too...]
>=20
> However, I see the error : can't find /lib/modules/2.4.17/modules.dep
> multiple times.
>=20
> Afcourse there is no such file or directory. I suspect that this
> directory and file should have been created when I compiled 2.4.17=20
> kernel but it did not. ( I did make bzImage )
>=20
> Can you please point out the problem and also the effect of this
> error because I cannot see any side effect of this error.
>=20
> Thanks
> Arun
>=20
>=20
> This e-mail and any attachments are confidential. If you are not the
> intended recipient, please notify us immediately by reply e-mail and then
> delete this message from your system. Do not copy this e-mail or any
> attachment, use the contents for any purposes, or disclose the contents to
> any other person: to do so could be a breach of confidence.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
"With Blue--uncertain stumbling Buzz--
 Between the light--and me--
 And then the Windows failed--and then
 I could not see to see--"
                      -emily dickinson

--RUqJLqMNe5u4kDWT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8T3yRjtKbcZaB/fERAo+oAJ4z6zo9QYPGbfvz7GY6UbtrlpmuDwCggDzt
HCVmaf1d/G3QXBPibdxBktE=
=lwoE
-----END PGP SIGNATURE-----

--RUqJLqMNe5u4kDWT--
