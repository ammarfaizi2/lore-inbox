Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265831AbUFDPnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbUFDPnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbUFDPnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:43:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49036 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265840AbUFDPmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:42:10 -0400
Date: Fri, 4 Jun 2004 17:41:42 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040604154142.GF16897@devserv.devel.redhat.com>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Fri, Jun 04, 2004 at 08:36:15AM -0700, Linus Torvalds wrote:
> 
> Add a tool to let people turn on/off the NX bit on an executable if it

the prelink rpm on Fedora has such a tool already fwiw.
(it's part of prelink because the elf manipulations needed are quite similar
to the ones prelink does so infrastructure is shared)


--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAwJg1xULwo51rQBIRAuvVAKCk+lGJNXBDz10F4lRftL2Yi0nBfACfYqla
yYzMZYMDtP8KlWWo/FrGacQ=
=tw2u
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
