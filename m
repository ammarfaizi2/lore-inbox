Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267876AbTBKOZB>; Tue, 11 Feb 2003 09:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTBKOZA>; Tue, 11 Feb 2003 09:25:00 -0500
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:47631 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id <S267876AbTBKOY6>; Tue, 11 Feb 2003 09:24:58 -0500
Message-Id: <200302111434.h1BEYiPY067260@sirius.nix.badanka.com>
Date: Tue, 11 Feb 2003 15:34:01 +0100
From: Henrik Persson <nix@socialism.nu>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
In-Reply-To: <1044973108.1118.89.camel@lemsip>
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com>
	<1044973108.1118.89.camel@lemsip>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="'K0f0:bZB=.:2Mde"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--'K0f0:bZB=.:2Mde
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 11 Feb 2003 14:18:28 +0000
Gianni Tedesco <gianni@ecsc.co.uk> wrote:

GT> On Tue, 2003-02-11 at 13:43, Henrik Persson wrote:
GT> > The problem is that my Via Rhine-NIC when transmitting alot of data fast
GT> > (like.. ftp:ing large files over the network at 100mbit/s) gets an error
GT> > (frame dropped, transmit error, reset).. As a cause of this the speed
GT> > drops to about 3-4MB/s and the rest of the communication trough the
GT> > network isn't working very well..
GT> > 
GT> > Note that this ONLY happens when there's alot of traffic (i.e. speeds at
GT> > ~100mbit/s)..
GT> 
GT> Have you tried connecting directly to the other device with a crossover
GT> cable, do problems still occur?

Yes, exactly the same problems occurs.

-- 
Henrik Persson
e-mail: nix@socialism.nu  WWW: http://nix.badanka.com
ICQ: 26019058             PGP/GPG: http://nix.badanka.com/pgp
PGP-Key-ID: 0x43B68116    PGP-Keyserver: pgp.mit.edu

--'K0f0:bZB=.:2Mde
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+SQne+uW4/EO2gRYRAmAgAJ0TVcbPH/55zioAUKzJQH9ExfNIfwCfcWyU
ps+rjzRThnojOOCw/VI8s/U=
=Aj8E
-----END PGP SIGNATURE-----

--'K0f0:bZB=.:2Mde--
