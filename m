Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131444AbRASOUq>; Fri, 19 Jan 2001 09:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131646AbRASOUg>; Fri, 19 Jan 2001 09:20:36 -0500
Received: from host213-120-148-5.btopenworld.com ([213.120.148.5]:866 "EHLO
	nvlonlx01.nv.london") by vger.kernel.org with ESMTP
	id <S131444AbRASOUZ>; Fri, 19 Jan 2001 09:20:25 -0500
Date: Fri, 19 Jan 2001 14:19:45 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Mo McKinlay <mmckinlay@gnu.org>, Peter Samuelson <peter@cadcamlab.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <004701c081ef$e32dcb90$8501a8c0@gromit>
Message-ID: <Pine.LNX.4.30.0101191417510.663-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:

  > Unfortunately, unix allows everything but "/" in filenames. This was
  > probably a mistake, as it makes it nearly impossible to augment the
  > namespace, but it is the reality.

  > Did you read the "new namespace" section of the paper?

I've not, so pardon me if I make a bad assumption (and slap me for it,
too), but doesn't introducing a new namespace segregate the streams from
the files/directories, thus introducing an artifical separation which
isn't really there? (Pretty much why I'm more in favour of a specific API
for reading streams, extended attributes and whatnot, over any of the
other solutions thus suggested).

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpoTQMACgkQRcGgB3aidfmurACdEb+w6gwUW7fc4FVdZ7umHlDs
/AgAoN8SOXejiKDd8G/KPVTP7qZwzhnO
=Ld9D
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
