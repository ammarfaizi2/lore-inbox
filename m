Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWERVic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWERVic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWERVic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:38:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12215 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750799AbWERVib (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:38:31 -0400
Message-Id: <200605182138.k4ILcTAA018105@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Don Bedsole <dbedsole@carolina.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nvidia legal to use by end-users?
In-Reply-To: Your message of "Thu, 18 May 2006 16:50:52 EDT."
             <200605181650.52537.dbedsole@carolina.rr.com>
From: Valdis.Kletnieks@vt.edu
References: <200605181650.52537.dbedsole@carolina.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147988308_16719P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 18 May 2006 17:38:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147988308_16719P
Content-Type: text/plain; charset=us-ascii

On Thu, 18 May 2006 16:50:52 EDT, Don Bedsole said:
> Question: If I download and install the Nvidia graphics card drivers from
> their site, am I violating the GPL as an end-user?  I was thinking the the
> GPL mainly covered what you are allowed or not allowed to do if you
> distribute software.  I ask because I saw on the OpenSuse site a statement to
> the effect that OpenSuse would not ship Nvidia, Ati drivers because some
> kernel developers consider them a violation of their copyrights.

Users, in general, can't violate the GPL.  You're free to do whatever you
want to your own system.  As long as you don't further give the drivers to
others, you're in the clear.

The reason OpenSuse won't ship it is because they *would* be giving the
drivers to others.  And one of these days NVidia may have to address the
status of the binary blobs they distribute (their non-Linux blob and
open shim layer isn't obviously illegal, but it isn't obviously legal either).

But if you download an NVidia driver for use on *your* system, and never
redistribute it, NVidia may have a problem for distributing it to *you*,
but you're in the clear.

--==_Exmh_1147988308_16719P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEbOlUcC3lWbTT17ARAoKUAKDJWJP9vfKw/6uYIWGs2lUkZ9961gCbBXwv
tacafgx0sI/GwHwv99Nyfiw=
=Edqn
-----END PGP SIGNATURE-----

--==_Exmh_1147988308_16719P--
