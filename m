Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbUKDEeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbUKDEeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 23:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUKDEeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 23:34:36 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:3222 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261972AbUKDEe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 23:34:29 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty sighandler
Date: Thu, 4 Nov 2004 05:11:44 +0100
User-Agent: KMail/1.7.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       cw@f00f.org
References: <20041103231735.8C1E955C79@zion.localdomain> <200411040451.iA44pJ5G012816@ccure.user-mode-linux.org>
In-Reply-To: <200411040451.iA44pJ5G012816@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1788379.LSYE4EkmTH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411040511.54892.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1788379.LSYE4EkmTH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 05:51, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > Avoid creating a dummy no-op procedure instead of using SIG_IGN.
>
> Andrew, can you hold off on this one?

> I did that on purpose, and as soon=20
> as I remember why, I'll know whether this patch is good :-)
I had a doubt on this, but I was not getting much feedback from you...
Also, if you reject this, I'd require a comment-only patch for it:
"as soon as I remember why" makes me think back to my yesterday's class, wh=
en=20
the teacher said "put comments in your code or you'll soon forget what it=20
does!" 8-O (yes, 1st year University student :-( ).

> The other patches are OK by me.  Consider them acked.
Very fine.

=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart1788379.LSYE4EkmTH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiawKqH9OHC+5NscRAmv5AJ9q2IMw9okRybgdmnCid2RrJY62owCgo4Ep
tiTalD+CqvTay6DvZsxJ5D0=
=dSwE
-----END PGP SIGNATURE-----

--nextPart1788379.LSYE4EkmTH--

