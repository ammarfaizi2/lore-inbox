Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131964AbRADSXu>; Thu, 4 Jan 2001 13:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbRADSXm>; Thu, 4 Jan 2001 13:23:42 -0500
Received: from ntx.cix.co.uk ([194.153.15.116]:10257 "EHLO nvlonlx01.nv.london")
	by vger.kernel.org with ESMTP id <S131964AbRADSXb>;
	Thu, 4 Jan 2001 13:23:31 -0500
Date: Thu, 4 Jan 2001 18:20:51 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: David Lang <david.lang@digitalinsight.com>
cc: Mo McKinlay <mmckinlay@gnu.org>, Chris Wedgwood <cw@f00f.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.31.0101041018430.10387-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.30.0101041820200.967-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, David Lang (david.lang@digitalinsight.com) wrote:

  > On Thu, 4 Jan 2001, Mo McKinlay wrote:
  >
  > >   > The off button need not and _does not_ remove power instantly (if at
  > >   > all) on many appliances.
  > >
  > > Indeed - but unplugging your VCR from the wall won't harm it. Everyone
  > > knows the power button on a TV/VCR/etc doesn't actually kill the power,
  > > just reduce consumption (i.e., standby mode). But unplugging it at the
  > > wall doesn't have any detrimental effects - doing that to a PC will.
  >
  > if you change that statement to "usually won't harm it" I agree with you
  > (I have had a VCR eat a tape when this was done)

Crikey. Most people would consider that a fault in the VCR.

Just goes to show how far removed from appliances PCs currently are.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpUvwcACgkQRcGgB3aidfkR3wCfVTY9NJY8irZ5BNxgQ1jrQWsP
3jIAnjVpIdJtOb66Q1wK451QPH00Q7wH
=90Eb
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
