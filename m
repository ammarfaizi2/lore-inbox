Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUEDQun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUEDQun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbUEDQun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:50:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45767 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264045AbUEDQuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:50:40 -0400
Date: Tue, 4 May 2004 18:47:15 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       bunk@fs.tum.de, eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040504164715.GA1077@devserv.devel.redhat.com>
References: <20040501161035.67205a1f.akpm@osdl.org> <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org> <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org> <16534.45589.62353.878714@napali.hpl.hp.com> <1083618424.3843.12.camel@laptop.fenrus.com> <16534.51724.578183.845357@napali.hpl.hp.com> <20040504075555.GB13287@devserv.devel.redhat.com> <16535.51307.910896.950581@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <16535.51307.910896.950581@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 04, 2004 at 09:44:27AM -0700, David Mosberger wrote:
> 
> You may well be right (it's hard to tell what they're using mlock()
> for since its called from the binary-only portion of the driver).
> However, as long as x86 supports the _syscallN() macros, they won't
> change.

I got the impression that just changed ;)

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAl8kSxULwo51rQBIRAnZMAJ453R5byWiXRj5nnshLSV0qFsnG/QCeMx8k
DmPojXef8y/5JhHldkag+GI=
=7qDO
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
