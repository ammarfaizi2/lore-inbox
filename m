Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130186AbQISCBd>; Mon, 18 Sep 2000 22:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129771AbQISCBY>; Mon, 18 Sep 2000 22:01:24 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:59151 "EHLO localhost.localdomain") by vger.kernel.org with ESMTP id <S129649AbQISCBG>; Mon, 18 Sep 2000 22:01:06 -0400
Date: Mon, 18 Sep 2000 20:47:08 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: umount report "busy" on r/o remount of root filesystem
Message-ID: <20000918204708.B11052@glitch.snoozer.net>
References: <39C611B9.2F96D99E@post.cz> <d3lmwpzvug.fsf@lxplus015.cern.ch> <39C61AD4.BEC29E72@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39C61AD4.BEC29E72@Hell.WH8.TU-Dresden.De>; from sorisor@Hell.WH8.TU-Dresden.De on Mon, Sep 18, 2000 at 03:38:28PM +0200
X-Operating-System: Linux glitch 2.4.0-test8 #1 SMP Sun Sep 10 19:24:39 CDT 2000 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I seem to be able to reliably reproduce it as well.  Let me know if I
can be of any help.

On Mon, Sep 18, 2000 at 03:38:28PM +0200, Udo A. Steinberg wrote:
> This should probably be added to the 2.4.x bug-list. Since Pavel
> seems to be able to constantly reproduce it, it should be possible to
> track the problem down with his help.

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5xsWcgrEMyr8Cx2YRAtnUAKDGX6q2DQjMoIPob1x65YWxAHZCBACfXltg
GAQTAVX97eejafbMAN4hA+s=
=LY15
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
