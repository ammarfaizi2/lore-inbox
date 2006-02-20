Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWBTGyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWBTGyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 01:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWBTGyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 01:54:37 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:13477 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932600AbWBTGyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 01:54:37 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 16:51:26 +1000
User-Agent: KMail/1.9.1
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Jan Merka <merka@highsphere.net>, Pavel Machek <pavel@ucw.cz>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <43EF24C0.2040902@gmail.com> <20060216215316.GH3490@openzaurus.ucw.cz>
In-Reply-To: <20060216215316.GH3490@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1823823.gb2mrssihv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602201651.40161.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1823823.gb2mrssihv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 17 February 2006 07:53, Pavel Machek wrote:
> > First we had swsusp... For many people it did not work, so
>
> ...no; for many people it was too slow and not nice enough...
>
> > Suspend2 was developed, but was not merged mainly because it
> > had too many UI components in-kernel.
>
> ...and because Nigel did not care about mainline for a *long* time.

Actually, it was more that I didn't want to try to merge something that was=
=20
still very much work in progress. You didn't seem to be doing any developme=
nt=20
on what was merged, so I didn't foresee any problems with just replacing it=
=20
once suspend(1|2|2.1|2.2) became mature. Patrick changed that, and then you=
=20
did too. And I learnt about the "merge early, merge often" mantra late in t=
he=20
game. If I knew then what I know now... but I didn't.

Regards,

Nigel

--nextPart1823823.gb2mrssihv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+Wb8N0y+n1M3mo0RAmgTAJwJgXU90v5xoDmL29DDumUUSB1pgQCfaYjP
iWzkbAdMYey9jZIgyLG44B0=
=5pVC
-----END PGP SIGNATURE-----

--nextPart1823823.gb2mrssihv--
