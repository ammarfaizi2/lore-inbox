Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291957AbSBTQV4>; Wed, 20 Feb 2002 11:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291962AbSBTQVq>; Wed, 20 Feb 2002 11:21:46 -0500
Received: from [213.171.51.190] ([213.171.51.190]:4737 "EHLO ns.yauza.ru")
	by vger.kernel.org with ESMTP id <S291957AbSBTQV1>;
	Wed, 20 Feb 2002 11:21:27 -0500
Date: Wed, 20 Feb 2002 19:21:23 +0300
From: Nikita Gergel <fc@yauza.ru>
To: lee johnson <lee@imyourhandiman.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: opengl-nvidia not compiling
Message-Id: <20020220192123.25786b72.fc@yauza.ru>
In-Reply-To: <1014218667.22795.1.camel@imyourhandiman>
In-Reply-To: <20020220015358.A26765@suse.de>
	<1014182978.21280.14.camel@imyourhandiman>
	<20020220170454.5e700732.fc@yauza.ru>
	<1014218667.22795.1.camel@imyourhandiman>
Organization: YAUZA-Telecom
X-Mailer: Sylpheed version 0.7.1 (GTK+ 1.2.10; i586-alt-linux)
X-Face: /kH/`k:.@|9\`-o$p/YBn<xFr)I]mglEQW0$I${i4Q;J|JXWbc}de_p8c1;:W~5{WV,.l%B S|A4'A1hnId[
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha1; boundary="=.ifQL0y8LJ.UX5X"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.ifQL0y8LJ.UX5X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 20 Feb 2002 07:24:26 -0800
lee johnson <lee@imyourhandiman.com> wrote:

> 
> > 
> > change all 'MINOR' to 'minor' and 'MAJOR' to 'major'
> > 
> > -- 
> > Nikita Gergel					System Administrator
> > Moscow, Russia					YAUZA-Telecom
> 
> before I go altering code that could adversely affect my card/system I'd
> like to know how you are assured this will work ( without causing damage
> etc.etc.)
> 
> please accept my thx in case i'm just being paranoid and this is fine
> :))

1. It's obvious. Try to understand meanings of MINOR in 2.4 and minor in 2.5 =)
2. I've compiled my NVIDIA kernel modules bringed in these fixes. I've no troubles.

-- 
Nikita Gergel					System Administrator
Moscow, Russia					YAUZA-Telecom

--=.ifQL0y8LJ.UX5X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8c80FFP8BYTTFfXkRAqUDAKDxkQbdPEdWgScgq5w+xnGWbIszhQCg5zw2
ZToiytsE7l06XlayT0w3gvM=
=TX5E
-----END PGP SIGNATURE-----

--=.ifQL0y8LJ.UX5X--

