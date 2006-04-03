Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWDCUjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWDCUjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWDCUjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 16:39:43 -0400
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:32702 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964876AbWDCUjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 16:39:43 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: john stultz <johnstul@us.ibm.com>
Subject: Re: Current git is great improvement for hibernation!
Date: Tue, 4 Apr 2006 06:38:33 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200604012215.52173.ncunningham@cyclades.com> <1144090960.2808.14.camel@leatherman>
In-Reply-To: <1144090960.2808.14.camel@leatherman>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1195830.XM1D4FxhH5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604040638.37791.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1195830.XM1D4FxhH5
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 04 April 2006 05:02, john stultz wrote:
> On Sat, 2006-04-01 at 22:15 +1000, Nigel Cunningham wrote:
> > Just a note to say "Wow." and "Thanks." I just updated to current git,
> > and the horrible long delay while drivers supend and resume is complete=
ly
> > gone! Veeeery nice! Kudos to John and his fellow time guys, I guess!
>
> Errr?  Glad its working, but it whuzuntme.
> <shrug>
> -john

Oh. Ok. I assumed you did something to remove that waiting for the start of=
 a=20
new second code, because the atomic copy seems like no delay at all now :)

Oh well. Hopefully whoever fixed whatever the issue really was is feeling=20
suitably chuffed :)

Regards,

Nigel

--nextPart1195830.XM1D4FxhH5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEMYfNN0y+n1M3mo0RAuYKAJ4s9a0ynJRMkj7SxUdFCsJ7na5dvQCcDZXL
CZASOSxevV5qaFZd6q7kphM=
=eI3w
-----END PGP SIGNATURE-----

--nextPart1195830.XM1D4FxhH5--
