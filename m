Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWAFIGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWAFIGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWAFIGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:06:36 -0500
Received: from main.gmane.org ([80.91.229.2]:15753 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964804AbWAFIGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:06:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Date: Fri, 06 Jan 2006 00:06:15 -0800
Message-ID: <43BE24F7.6070901@triplehelix.org>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3291B7CDB9F0750DA714B9F9"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-188-42.dsl.pltn13.pacbell.net
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
In-Reply-To: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3291B7CDB9F0750DA714B9F9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 01/03/2006 02:20 PM, Sebastian wrote:
> The second series was ripped with deprecated ide-scsi emulation and yielded the
> same results as EAC.

What were you using? cdparanoia? cdda2wav? (Are there actually that many
other options on Linux?)

This may well be a userspace problem, where your ripping program doesn't
perform enough integrity checks on the data it's just read, and ide-scsi
happens to make things slow enough for errors to not occur?

Shooting in the dark,

-- 
Joshua Kwan

--------------enig3291B7CDB9F0750DA714B9F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQ74k+aOILr94RG8mAQLFERAA891BWi1tAINWJ4OsW2pbRZQqLkjWIVjs
PHvne0HU+wudKaM16VkuBUzsKANgwNfAbpi46MpaHMLh16xsppB1pcixt1E8ybq9
KNAjDBIlwXhtbsIXbc+uqnxOfViJd//oibHOkbiaenDLHBLR35eISo/96xLZmNdG
XZc8iTyYpt5bLZQzE3fG06V6eyh73AqiW2A8YKBOn5Si1HWD4k+/oAUK9DxSikF5
2RV50090ycZgSKbYjPZ+d6S4DhkQ64KgYa5ME9Ea51j8nkiZDFFREoDAdAxfDmGK
MSXPoRXUO2rKVDeY7Lxy48ZjqblYToZ1z9DiecVlmQ1zTs/3nyLtnQIT+MJE+/8h
LrcsPZPTWuLI60p+Z3UHIJWo+d4mtvtc+kO1FBwi7myi0gfYwLLEqEy0bW98RP37
+cADvkTIFlcwwR5SxrQJTckTxNiJ4OlRBxoePEn371cp+Oh22dLeSfFdhkPp33B+
H9/v/5Zl8hHgkpsHQyZBDKiNrg4Nbs1DgwGOQYPtQjP5G8fByNVdCFcM4Y+VNn9M
/vn2xKSiFbZy6s9HYx3ruyUtFwmCNBqsT4a4uyjrHgHhpB6WBW7tSxTfFquglk0L
W6dgI0qKGtDmu6DTfxMGx+LvzKW6mXwAvg08SIkaTgBO2vfKS1Fl6DrWQ+RLsno0
I5ndqej4vxc=
=gU+O
-----END PGP SIGNATURE-----

--------------enig3291B7CDB9F0750DA714B9F9--

