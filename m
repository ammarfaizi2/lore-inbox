Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUDAKqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUDAKq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:46:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32687 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262850AbUDAKnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:43:41 -0500
Date: Thu, 1 Apr 2004 12:43:14 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org,
       "Surendra I." <surendrai@esntechnologies.co.in>
Subject: Re: Flash Media block driver problem!
Message-ID: <20040401104314.GA1751@devserv.devel.redhat.com>
References: <1118873EE1755348B4812EA29C55A972176F95@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A972176F95@esnmail.esntechnologies.co.in>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Apr 01, 2004 at 03:53:41PM +0530, Jinu M. wrote:
> 
> On Thu, 2004-04-01 at 12:03, Jinu M. wrote:
> > Hi All,
> > 
> > We are developing a block device driver (2.4.x kernel) for Flash Media devices
> why?
> aren't the existing usb/IDE drivers working for you ??
> 
> [jinum] This is not a USB/IDE(ATA)/SCSI based device. The controller is directly mapped to the PCI Bus. So we basically write a device driver like the once which are in drivers/block/*.c (non-IDE).

cool; linux can use a GPL driver for such things...

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAa/JBxULwo51rQBIRAnO3AKCgrZRtR0kAoEfZjmsbHW8udg/EuACgmtgt
PloLn7S+Y47Hm5Ns3aD05io=
=PwiY
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
