Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135245AbRASQIa>; Fri, 19 Jan 2001 11:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135288AbRASQIZ>; Fri, 19 Jan 2001 11:08:25 -0500
Received: from host213-120-148-5.btopenworld.com ([213.120.148.5]:19049 "EHLO
	nvlonlx01.nv.london") by vger.kernel.org with ESMTP
	id <S135245AbRASQIK>; Fri, 19 Jan 2001 11:08:10 -0500
Date: Fri, 19 Jan 2001 16:07:47 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A686599.470272D6@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.30.0101191606270.2331-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:

  > Oh, undoubtedly.  But NTFS already disallows several characters in valid
  > filenames. This also violates the "consistent abstract interface." But
  > it's reality.

Nono, that's not what I mean - each of the filesystems fails if it
doesn't support what you're trying to do, that's given - but having a
different delimeter registered by the filesystem (and hence the
possibility of every single filesystem using a different delimeter) brings
about a completely different kind of inconsistency.

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpoZlQACgkQRcGgB3aidfnnNACcC99aXvrG1lsbEv5rr8wpGrTe
ZScAn1TCpbviEGzWn6UGHhqTgQVVSqVp
=UL3r
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
