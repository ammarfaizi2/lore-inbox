Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272167AbTGYP70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272168AbTGYP70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:59:26 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:43015 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S272167AbTGYP7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:59:24 -0400
Date: Fri, 25 Jul 2003 09:14:21 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: Sam Bromley <sbromley@cogeco.ca>, Torrey Hoffman <thoffman@arnor.net>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725161421.GL23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Sam Bromley <sbromley@cogeco.ca>,
	Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>
References: <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org> <20030725155355.GJ23196@ruvolo.net> <20030725154715.GH1512@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3xQkynibq3FKlJyM"
Content-Disposition: inline
In-Reply-To: <20030725154715.GH1512@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3xQkynibq3FKlJyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2003 at 11:47:15AM -0400, Ben Collins wrote:
> That's exactly what it looked like, and the info is exactly what I
> thought would be produced. Could you tell me the value for HZ on your
> system? Also try the patch I sent just prior to this email.

Its an x86, and I didn't do anything to change the default.. so I believe
its HZ=1000 (at least, thats what include/asm/param.h says).

> Thanks, your testing is very helpful.

Thanks for taking the time to go through this.

-Chris

--3xQkynibq3FKlJyM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IVddKO6EG1hc77ERAnf9AKCjtRgAH2SgWb0GruJIePs0GJ/eYQCghFcS
NoPM98P6J7ufV9OjjsNMC9w=
=2YQV
-----END PGP SIGNATURE-----

--3xQkynibq3FKlJyM--
