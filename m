Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUG3KEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUG3KEh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 06:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUG3KEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 06:04:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264419AbUG3KEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 06:04:33 -0400
Date: Fri, 30 Jul 2004 11:04:21 +0100
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: manfred@colorfullife.com
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
Message-ID: <20040730100421.GB8175@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E0VqhFbWSXkyZBiT"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E0VqhFbWSXkyZBiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The patch in:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0406.3/1399.html

causes the forcedeth driver to fail for me.  See:

  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128292

for a description of the symptoms.  Basically it says:

  kernel: eth0: no link during initialization.

Works fine if I back out that patch.

Tim.
*/

--E0VqhFbWSXkyZBiT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBCh0k9gevn0C09XYRAp80AJ9Ud1KWvlHnJCC8TnUECIBFhVsP/wCfdgqV
o6xnRbHuzORadqcUjyJUJBI=
=ZRt8
-----END PGP SIGNATURE-----

--E0VqhFbWSXkyZBiT--
