Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUCUHrf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 02:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbUCUHrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 02:47:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22468 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263618AbUCUHrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 02:47:33 -0500
Date: Sun, 21 Mar 2004 08:47:11 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
Message-ID: <20040321074711.GA13232@devserv.devel.redhat.com>
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <405CFC85.70004@backtobasicsmgmt.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Sat, Mar 20, 2004 at 07:23:01PM -0700, Kevin P. Fleming wrote:
> Jeff Garzik wrote:
> 
> >So go ahead, and I'll lend you as much help as I can.  I have the full 
> >Promise RAID docs, and it seems like another guy on the lists has full 
> >Silicon Image "medley" RAID docs...
> 
> If these "soft" RAID implementations only support RAID-0/1/0+1/1+0, is 
> there really any need for a new DM target? Wouldn't you just need a 
> userspace tool to recognize the array and do the "dmsetup" operations to 
> make it usable?

the later.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAXUh+xULwo51rQBIRAo1wAJ9NUms82l+rS1gMLRPm3SnTVPHTRgCgor/W
IvlDA5yYYJR9wTJCx9Y7PjI=
=s0Cl
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
