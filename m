Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWHVVEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWHVVEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWHVVEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:04:38 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:54662 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S1750706AbWHVVEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:04:37 -0400
Date: Tue, 22 Aug 2006 14:04:32 -0700
From: Seth Arnold <seth.arnold@suse.de>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 2/8] Integrity Service API and dummy provider
Message-ID: <20060822210432.GF2584@suse.de>
Mail-Followup-To: Kylene Jo Hall <kjhall@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSM ML <linux-security-module@vger.kernel.org>,
	Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
	Serge Hallyn <sergeh@us.ibm.com>
References: <1155844392.6788.56.camel@localhost.localdomain> <20060817232202.GN2584@suse.de> <1156276877.6720.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7aQJ/pUO7E0NVzIB"
Content-Disposition: inline
In-Reply-To: <1156276877.6720.16.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7aQJ/pUO7E0NVzIB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2006 at 01:01:17PM -0700, Kylene Jo Hall wrote:
> measure is standard TCG nomenclature refering to calculating the hash of
> a file and extending that value into the TPM to be able to verify what
> has run on the system.  Here are a couple of references for sample term
> use: [1]
> http://domino.research.ibm.com/comm/research_projects.nsf/pages/ssd_ima.index.html
> [2] https://www.trustedcomputinggroup.org/news/articles/rc23363.pdf

Thanks for the pointers. Much appreciated.

And thanks for the detailed responses to my various questions. Always
nice to learn. :)

--7aQJ/pUO7E0NVzIB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFE63Fg+9nuM9mwoJkRAo5sAJ4mUFFxilSr726pwv05cT2DF4DCnACgm4vp
JVtu+9CcIT6qPpujekvDLOw=
=VJWC
-----END PGP SIGNATURE-----

--7aQJ/pUO7E0NVzIB--
