Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUEFOQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUEFOQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUEFOPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:15:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20147 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262453AbUEFOOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:14:03 -0400
Date: Thu, 6 May 2004 16:09:40 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Sourav Sen <souravs@india.hp.com>, Matt_Domsch@dell.com,
       Matthew E Tolentino <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Message-ID: <20040506140940.GI22748@devserv.devel.redhat.com>
References: <003801c43347$812a1590$39624c0f@india.hp.com> <20040506114414.A14543@infradead.org> <20040506115919.GZ2281@parcelfarce.linux.theplanet.co.uk> <1083845904.3844.2.camel@laptop.fenrus.com> <20040506132711.GA2281@parcelfarce.linux.theplanet.co.uk> <1083852039.2811.55.camel@nighthawk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline
In-Reply-To: <1083852039.2811.55.camel@nighthawk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, May 06, 2004 at 07:00:40AM -0700, Dave Hansen wrote:
> I think what Arjan doesn't want is 14 different architectures with 14
> different userspace programs reading 14 different things in /proc and
> /sys for each of their memory hotplug schemes. 

*exactly*

well 14 architecture and 28 programs because firmware got rev'ed ;)


--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAmkcjxULwo51rQBIRAkqMAKCljdClekOzwTeBTye28elPWu0uzwCeMSBo
5khGSAhZauJtzlj7VXg2ZHs=
=u86K
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--
