Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUDEIzb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUDEIzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:55:31 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:49048 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263184AbUDEIzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:55:23 -0400
From: Matthias Juchem <lists@konfido.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25: kernel BUG at inode.c:334
Date: Mon, 5 Apr 2004 10:55:04 +0200
User-Agent: KMail/1.5.4
References: <200404041752.25721.lists@konfido.de> <20040405001942.GA1879@logos.cnet>
In-Reply-To: <20040405001942.GA1879@logos.cnet>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_27RcAwHPwkZfo7E";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404051055.18712.lists@konfido.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_27RcAwHPwkZfo7E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi Marcelo.

On Monday 05 April 2004 02:19, you wrote:
> This bug should be fixed in 2.4.26-rc1. Please try it.

Yes, Marc-Christian told me this, too.

I'm currently installing a patched kernel (2.4.25 + ChangeSet 1.1330). If t=
his=20
one runs one month without problems, the problem should be fixed :)

Best regards,
 Matthias

--Boundary-02=_27RcAwHPwkZfo7E
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAcR72FJbl3HvkyPURAi6mAJ4gWq1I4c+Or8EVgIBnuI99wdbSuQCfRCOK
ID4Vr2w2AuaItbU9O4CBYlE=
=QjPL
-----END PGP SIGNATURE-----

--Boundary-02=_27RcAwHPwkZfo7E--

