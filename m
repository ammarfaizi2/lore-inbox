Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUEYNBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUEYNBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUEYNBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:01:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5800 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262009AbUEYNBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:01:47 -0400
Date: Tue, 25 May 2004 15:01:16 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040525130116.GA16852@devserv.devel.redhat.com>
References: <20040524210146.GA5532@kroah.com> <1085468008.2783.1.camel@laptop.fenrus.com> <20040525080006.GA1047@kroah.com> <20040525113231.GB29154@parcelfarce.linux.theplanet.co.uk> <20040525125452.GC3118@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20040525125452.GC3118@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Tue, May 25, 2004 at 09:54:53AM -0300, Marcelo Tosatti wrote:
> > > Marcelo, feel free to tell me otherwise if you do not want
> > > this in the 2.4 tree. 
> 
> Is this code necessary for PCI-Express devices/busses to work properly?

afaik not. It's an enhancement to make config space access to them somewhat
faster, but they just work using the existing method.


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAs0OcxULwo51rQBIRAuT6AKCenSSbR5KpYxhqOaM4o/fkggAcNwCgnlai
9nmRDfwxXrKr7lmSI3HbNqY=
=OXim
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
