Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWGQCJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWGQCJD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 22:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWGQCJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 22:09:03 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:2026 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932214AbWGQCJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 22:09:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=ZH0ZOEgPdnXC4eeaKMo4fb0WpC1apfuSc8yPrMM+HEhawQ9NesIM+igopn9qg5ijp43m7gCw7M+Y6fZfWgQIBtXHL0R1CWX0YTRfMA2M/C15W3akfEUsVSTNZp7cEb3+BfZfaP7ykSQ24yzI4RYRgdMgXPPa9jEQzd5+zoanxrw=
Date: Sun, 16 Jul 2006 22:08:58 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: lm90 no longer working
Message-ID: <20060717020858.GA20290@phoenix>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a hardware monitoring chip in my laptop that uses the lm90
driver, and somewhere between 2.6.16 and 2.6.17, it stopped working.  I
don't know why.  I'm going to try installing a bunch of different
versions to track down which version precisely stopped working, but I'm
curious if anyone has any ideas about what might have caused this.

-- Thomas Tuttle

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEuvE6/UG6u69REsYRAjPMAJ9wZ7YvDZgJVGUR5Dn95ST9k+D4sgCfSKe4
lhldfEQ44xTb5pkjkd1tD8k=
=8vEC
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
