Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbTCLPFH>; Wed, 12 Mar 2003 10:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbTCLPFH>; Wed, 12 Mar 2003 10:05:07 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:62875 "EHLO phoebee")
	by vger.kernel.org with ESMTP id <S261612AbTCLPFF>;
	Wed, 12 Mar 2003 10:05:05 -0500
Date: Wed, 12 Mar 2003 16:15:41 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: "Donald Zoch" <donald.zoch@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module to detect sigsegv
Message-Id: <20030312161541.75c49f3e.martin.zwickel@technotrend.de>
In-Reply-To: <20030312081821.G12608@lard.amd.com>
References: <20030312081821.G12608@lard.amd.com>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Ww40pW6xaqDH+:"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Ww40pW6xaqDH+:
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Donald!

Hope this helps a little bit:
http://www.kyuzz.org/antirez/sigsegv/

Regards,
Martin

On Wed, 12 Mar 2003 08:18:21 -0600
"Donald Zoch" <donald.zoch@amd.com> bubbled:

> I'm new to kernel programming and have set the goal of writing
> a kernel module to detect signal 11 errors and log them.  
> My question is what is the best way to attack this in a module? 
> I've figured out how to write a basic module, but I'm having a
> hard time figuring out how to do the checking.
> How can I look at every signal that the kernel sends to processes
> and pick out those that I want to report on? 
> 
> Apologies for sending this to the main list.  kernelnewbies doesn't
> seem to be working any longer.
> 
> Thanks,
> 
> Donald
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Martin Zwickel <martin.zwickel@technotrend.de>

Research & Development

TechnoTrend AG <http://www.technotrend.de>
Werner-von-Siemens-Str. 6
86159 Augsburg

Tel: [+49-821-450448-16] <---> Fax: [+49-821-450448-11]

--------------------------------------------------------------------
This email, together with any attachments,  is for the exclusive and
confidential use of the addressee(s). Any other distribution, use or
reproduction without the sender's prior consent is  unauthorised and
strictly  prohibited.  If  you have received this message  in error,
please notify the sender by email immediately and delete the message
from your computer without making copies.

--=.Ww40pW6xaqDH+:
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+b08gmjLYGS7fcG0RAmfoAJwNHXbQXS921hJ/ouY09nGSoeKM8wCfVtFb
1pfjc76iFANSDeBRFngDNyo=
=97tR
-----END PGP SIGNATURE-----

--=.Ww40pW6xaqDH+:--
