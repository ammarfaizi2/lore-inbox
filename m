Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269976AbUJNGpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269976AbUJNGpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 02:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269979AbUJNGpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 02:45:51 -0400
Received: from lugor.de ([217.160.170.124]:52609 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S269976AbUJNGps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 02:45:48 -0400
From: Christian Hesse <christian.hesse@linuxob.de>
Organization: Linux Oberhausen
To: linux-kernel@vger.kernel.org
Subject: Re: Software Suspend with ck
Date: Thu, 14 Oct 2004 08:45:45 +0200
User-Agent: KMail/1.7
References: <200410111348.45497.mail@earthworm.de>
In-Reply-To: <200410111348.45497.mail@earthworm.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1153455.lpq0hSnmjN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410140845.45157.christian.hesse@linuxob.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1153455.lpq0hSnmjN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 October 2004 13:48, Christian Hesse wrote:
> Hello!
>
> Con Kolivas repoted this to work for him, but he also told me he's
> clutching at straws since his swsusp knowledge is small and
> Pavel Machek explained freeing memory is basically vm code he only
> calls. So I post this here everybody can read it.
>
> Trying to suspend an ck-kernel results in the system hanging while freeing
> memory. This behavior is caused by Staircase scheduler. Sane 2.6.9-rc{3,4}
> works fine.
>
> Any chance to get it working? Let me know if you need more inforamtion.

If anybody is interested: Suspend works just fine with 2.6.9-rc4-ck2.

=2D-=20
Christian Hesse

geek by nature
linux by choice

--nextPart1153455.lpq0hSnmjN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBbiCZlZfG2c8gdSURAki+AJ0Wq4qrb9stoL7e6xK0l9N920BRJQCg6ISu
8dSvH0c51LBPG38wJ4Ko6jM=
=s/Ja
-----END PGP SIGNATURE-----

--nextPart1153455.lpq0hSnmjN--
