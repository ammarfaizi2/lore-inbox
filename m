Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWDLJW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWDLJW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWDLJW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:22:27 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:50315 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751055AbWDLJW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:22:26 -0400
Message-ID: <443CC6CE.6070102@stesmi.com>
Date: Wed, 12 Apr 2006 11:22:22 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Pramod Srinivasan <pramods@gmail.com>, David Weinehall <tao@acc.umu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL issues
References: <fcff6ec10604120001o18ca9edxf11ed055b5601e2a@mail.gmail.com> <Pine.LNX.4.61.0604121057360.12544@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604121057360.12544@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig1DDD756BE977F9D9675AD27B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DDD756BE977F9D9675AD27B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Engelhardt wrote:
> <obligatory_ianal_marker>
> 
>>Suppose I use the linux-vrf patch for the kernel that is freely
>>available and use the extended setsocket options such as SO_VRF in an
>>application, do I have to release my application under GPL since I am
>>using a facility in the kernel that a standard linux kernel does not
>>provide?
>>
> 
> 
> If vrf has no other uses besides your proprietary application, I'd shudder.

So in order for you not to shudder the vrf people have to write a GPL'd
program or convince someone else to write one?

That sounds .. really odd.

Or more to the point, someone ONLY writes kernelmode stuff, doesn't
touch userspace at all. A proprietary app shows up that uses it,
and all of a sudden this guy's kernelmode whatever is disliked
cause noone wrote any GPL'd program for it?

That's almost forcing the person who wrote the kernel part to write
a GPL'd program JUST because there is a proprietary program using
his stuff - and THAT is insane.

// Stefan

--------------enig1DDD756BE977F9D9675AD27B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEPMbRBrn2kJu9P78RA45jAJ4oFMo6dasmx7Ctjm8FVOJkn0RDsgCgne2C
D2Ml+edXNb5usgGW/DnVMHU=
=5I43
-----END PGP SIGNATURE-----

--------------enig1DDD756BE977F9D9675AD27B--
