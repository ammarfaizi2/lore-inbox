Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132892AbRDENOA>; Thu, 5 Apr 2001 09:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132893AbRDENNu>; Thu, 5 Apr 2001 09:13:50 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:12602 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132892AbRDENNf>; Thu, 5 Apr 2001 09:13:35 -0400
Date: Thu, 5 Apr 2001 14:12:48 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Bart Trojanowski <bart@jukie.net>
Cc: =?iso-8859-1?Q?Sarda=F1ons=2C_Eliel?= 
	<Eliel.Sardanons@philips.edu.ar>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
Message-ID: <20010405141248.Z9355@redhat.com>
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER> <Pine.LNX.4.30.0104050901500.13496-100000@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EUwkhXZbCcD53YNR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104050901500.13496-100000@localhost>; from bart@jukie.net on Thu, Apr 05, 2001 at 09:06:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EUwkhXZbCcD53YNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05, 2001 at 09:06:20AM -0400, Bart Trojanowski wrote:

> So you ask: "why not just use a { ... } to define a macro".  I don't
> remember the case for this but I know it's there.  It has to do with a
> complicated if/else structure where a simple {} breaks.

It's for eating the semi-colon after the macro invocation.

Tim.
*/

--EUwkhXZbCcD53YNR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6zG9PONXnILZ4yVIRAn46AJ9qAOqXytZwZ5LmJj9B4o8tNgzefwCfV94b
TJcxDB2GBbVHXSN1g6PA9Cw=
=YurY
-----END PGP SIGNATURE-----

--EUwkhXZbCcD53YNR--
