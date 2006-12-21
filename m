Return-Path: <linux-kernel-owner+w=401wt.eu-S1423019AbWLUSaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423019AbWLUSaJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423014AbWLUSaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:30:08 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:34012 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423019AbWLUSaH (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:30:07 -0500
Message-Id: <200612211827.kBLIRtqC025054@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Dan Williams <dcbw@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jiri Benc <jbenc@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
In-Reply-To: Your message of "Wed, 20 Dec 2006 22:06:51 EST."
             <1166670411.23168.13.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <20061220150009.1d697f15@griffin.suse.cz> <1166638371.2798.26.camel@localhost.localdomain> <20061221011526.GB32625@srcf.ucam.org>
            <1166670411.23168.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166725675_12674P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Dec 2006 13:27:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166725675_12674P
Content-Type: text/plain; charset=us-ascii

On Wed, 20 Dec 2006 22:06:51 EST, Dan Williams said:
> It's also complicated because some switches are supposed to rfkill both
> an 802.11 module _and_ a bluetooth module at the same time, or I guess
> some laptops may even have one rfkill switch for each wireless device.

On my Dell D820, it's bios-selectable if the switch is enabled, or if
it controls just the 802.11 card, or 802.11 and bluetooth, or just bluetooth,
or 802.11 and mobile broadband, or ...

This way lies madness. :)

(Oddest part - said bios config screen offers the choices for bluetooth
and mobile broadband even though the hardware config doesn't include it. ;)

--==_Exmh_1166725675_12674P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFitIrcC3lWbTT17ARAmxaAKDaqP5WCL22hXx/TKkLUzP65rrkXgCg6jtv
Pq2mF9jGpOFxCv3vsP2cFc8=
=+ohu
-----END PGP SIGNATURE-----

--==_Exmh_1166725675_12674P--
