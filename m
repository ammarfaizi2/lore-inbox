Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271822AbTGRPGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271799AbTGRPDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:03:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8064 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267576AbTGRO3G (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:29:06 -0400
Message-Id: <200307181443.h6IEhnq3002916@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Danek Duvall <duvall@emufarm.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O6.1int 
In-Reply-To: Your message of "Fri, 18 Jul 2003 00:07:49 PDT."
             <20030718070749.GA12466@lorien.emufarm.org> 
From: Valdis.Kletnieks@vt.edu
References: <200307171635.25730.kernel@kolivas.org> <20030717080436.GA16509@lorien.emufarm.org>
            <20030718070749.GA12466@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1933694032P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Jul 2003 10:43:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1933694032P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Jul 2003 00:07:49 PDT, Danek Duvall said:

> I did discover under O6.1int that I could make xmms block indefinitely
> when opening a window, with fvwm's wire frame manual placement, which I
> hadn't ever noticed before, but I'm not sure if that's because it
> actually wasn't there before, or I just placed the windows more quickly.

This could be a result of fvwm grabbing the X server while the wireframe stuff
is going on, and xmms being blocked trying to update the image on screen
(think "scrolling song title" ;)


--==_Exmh_-1933694032P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/GAekcC3lWbTT17ARAiecAKDGK79DU8uB31KPOGGZ3IlLKKk8dwCgvbNe
ksJ7rslDM59C/Tt2ccNjxsw=
=4EM0
-----END PGP SIGNATURE-----

--==_Exmh_-1933694032P--
