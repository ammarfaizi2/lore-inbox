Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131070AbRADSSU>; Thu, 4 Jan 2001 13:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRADSSK>; Thu, 4 Jan 2001 13:18:10 -0500
Received: from ntx.cix.co.uk ([194.153.15.116]:13841 "EHLO nvlonlx01.nv.london")
	by vger.kernel.org with ESMTP id <S131070AbRADSSA>;
	Thu, 4 Jan 2001 13:18:00 -0500
Date: Thu, 4 Jan 2001 18:15:26 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Lang <david.lang@digitalinsight.com>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <20010105071053.A31025@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.30.0101041813310.967-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



  > The off button need not and _does not_ remove power instantly (if at
  > all) on many appliances.

Indeed - but unplugging your VCR from the wall won't harm it. Everyone
knows the power button on a TV/VCR/etc doesn't actually kill the power,
just reduce consumption (i.e., standby mode). But unplugging it at the
wall doesn't have any detrimental effects - doing that to a PC will.

Being able to change what the power button does is cool, but it does mask
the real issue - what happens when you pull the plug, and how do you make
it so that it's acceptable?

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpUvcEACgkQRcGgB3aidflzEwCgpYdN7Tp7e1S3HGoTA6JKBS40
+GUAn20lCCVeqJbPzJ5k+qJd1OHsZjqu
=YQ4B
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
