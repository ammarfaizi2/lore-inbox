Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132584AbRARVta>; Thu, 18 Jan 2001 16:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136003AbRARVtU>; Thu, 18 Jan 2001 16:49:20 -0500
Received: from wpk-smtp-relay2.cwci.net ([195.44.63.19]:55370 "EHLO
	wpk-smtp-relay.cwci.net") by vger.kernel.org with ESMTP
	id <S132584AbRARVtC>; Thu, 18 Jan 2001 16:49:02 -0500
Date: Thu, 18 Jan 2001 21:30:10 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Mo McKinlay <mmckinlay@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <14950.16631.2919.360911@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.30.0101182129050.1089-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yesterday, Peter Samuelson (peter@cadcamlab.org) wrote:

  > Yeah, I agree, 'file/stream' is lousy syntax as well.  If it weren't
  > for the possibility of having streams on directories, it would almost
  > be acceptible.  I still don't know which (':' or '/') is the worse
  > hack.

Me neither :/

  > As I've said elsewhere in this thread, I can't think of *any* clean way
  > to shoehorn forks into nice, transparent posix calls.  It really wants
  > a new API.

Likewise. This was my standpoint the last time around - a clear concise
portable API for accessing streams (even if it *started out*
Linux-specific) - without imposing silly semantics on existing
applications which currently ignore streams anyway.

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpnYGQACgkQRcGgB3aidfmWBQCfXgNq/vqltt76mApoDiNI9HnH
ws8AoJZ2vvlH1iCAeUu7yktWWN0Bncc3
=gEmD
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
