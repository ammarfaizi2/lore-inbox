Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTIRM3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTIRM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:29:52 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:11706 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S261216AbTIRM3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:29:51 -0400
Date: Thu, 18 Sep 2003 15:29:35 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Daniel Hardt <dh@id.cbs.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cirrus Logic Crystal CS4281 PCI Audio
Message-ID: <20030918122935.GL1859@actcom.co.il>
References: <20030918.141638.104060144.dh@id.cbs.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
Content-Disposition: inline
In-Reply-To: <20030918.141638.104060144.dh@id.cbs.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2003 at 02:16:38PM +0200, Daniel Hardt wrote:
> I have an IBM X21 thinkpad with a Cirrus Logic Crystal CS4281 PCI
> Audio sound chip.  Our system guy has not been able to get it to work
> under linux.  below is the lspci output.  any ideas would be much
> appreciated.  Please cc me.

Which kernel version? Assuming a 2.6 kernel, what is the output of
'insmod cs4281.o'? 'insmod snd-cs4281.o'? Please supply more details -
e.g., what you tried, what you expected to happen, and what actually
happened.=20

Cheers,=20
Muli=20

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/aaUuKRs727/VN8sRAnErAJ4lPe4J5i6Imh8Z9eqJrXWz8FzndQCgqIwI
SJaxBZr0iFkF58Ioos2oAyE=
=JQxz
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
