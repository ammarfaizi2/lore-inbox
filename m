Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265339AbUEZHiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUEZHiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUEZHiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:38:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1995 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265339AbUEZHiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:38:12 -0400
Date: Wed, 26 May 2004 09:37:53 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Len Brown <len.brown@intel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org,
       "linux-pci@atrey.karlin.mff.cuni.cz" 
	<linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: ACPI & 2.4 (Re: [BK PATCH] PCI Express patches for 2.4.27-pre3)
Message-ID: <20040526073752.GF6742@devserv.devel.redhat.com>
References: <A6974D8E5F98D511BB910002A50A6647615FC676@hdsmsx403.hd.intel.com> <1085556934.26254.132.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <1085556934.26254.132.camel@dhcppc4>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 26, 2004 at 03:35:34AM -0400, Len Brown wrote:
> Yes, the ACPI part to enable MMconfig was pretty small.
> We parse a table in the standard way and set a global variable --
> that's about it.
> 
> I submitted it to 2.4 for the sole purpose
> to enable Greg to enable native PCIExpress.
> 
> I expect demand for this in 2.4 as the major distros'
> enterprise releases are still 2.4 based and the hardware has
> arrived... 

yet those enterprise releases won't go to newer 2.4 upstream releases....


--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAtElQxULwo51rQBIRAjVhAJwMo99pNAnsY/243WD9R5K32LiKdACfaXFo
/8OrSxN/L/6ic915QP2ecAo=
=F8xI
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
