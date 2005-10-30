Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932818AbVJ3G43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbVJ3G43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 01:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932829AbVJ3G43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 01:56:29 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:53963 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932818AbVJ3G43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 01:56:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=VDP6ABiQ+7cJtRyLMb6sNkw43yYpj0mQDqc3pN75eFb1kjRPJHkJRcwwkt15wcv/oUxph+eDtquWWqXztF6Ym5F3gdHemD9pvTXd8pBurnCCA3p8SHO7Kmf5hIu8C4MAZZXKmjyU/OX5RH9aJTdnIA9eICrb1pPNlwwfYQH+WTU=
From: Patrick McFarland <diablod3@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
Date: Sun, 30 Oct 2005 02:56:08 -0400
User-Agent: KMail/1.8.3
Cc: David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain> <20051030011959.GA17750@vasa.acc.umu.se> <Pine.LNX.4.58.0510292343280.10073@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510292343280.10073@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7304721.iD01GcZvdZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510300156.16277.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7304721.iD01GcZvdZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 29 October 2005 11:48 pm, Steven Rostedt wrote:
> On Sun, 30 Oct 2005, David Weinehall wrote:
> > Uhm, this patch assumes that you're using bash as /bin/sh.
> > Not everyone does.  (I haven't checked the rest of the system calls
> > in ketchup though, maybe this is a more generic problem?)
>
> OK, if I work any more on ketchup, I'm going to convert the whole damn
> thing into perl! ;-} (and call it "mustard").

I hope you relish this problem. ;)

=2D-=20
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989


--nextPart7304721.iD01GcZvdZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDZG6Q8Gvouk7G1cURAhQxAKCYVBKZ1RadfiGAIpMMo8uqqj/Q7QCgloU6
MikQkp6NdkHgOAURL2xGRvc=
=sxUC
-----END PGP SIGNATURE-----

--nextPart7304721.iD01GcZvdZ--
