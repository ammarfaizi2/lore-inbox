Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUGIJsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUGIJsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUGIJsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:48:39 -0400
Received: from mout0.freenet.de ([194.97.50.131]:32707 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S264685AbUGIJsc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:48:32 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: Kernel fchown() exploit status?
Date: Fri, 9 Jul 2004 11:46:30 +0200
User-Agent: KMail/1.6.2
References: <40EDB764.6060107@securesystem.info> <20040708162414.I1973@build.pdx.osdl.net>
In-Reply-To: <20040708162414.I1973@build.pdx.osdl.net>
Cc: Chris White <webmaster@securesystem.info>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407091146.32077.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Chris Wright <chrisw@osdl.org>:
> * Chris White (webmaster@securesystem.info) wrote:
> > There was a recent security announcment regarding a vulnerability with 
> > the fchown function.
> > 
> > Only a few distrobutions (red hat/suse) have fixed the issue, but I've 
> > yet to see a general patch for it.
> 
> Patches are in both 2.4 and 2.6 bk trees.  2.4.27-rc3 has this fixed.
> There hasn't been a 2.6.8-rc release since the patches went in to 2.6

Is there an exploit available to test if the kernel has
this vulnerability?

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7ml2FGK1OIvVOP4RAtU7AKCX9p7P389fBEfb1uY0q0VEgKYYfACgjY3x
X4nZPpoLbFJVpRwQOtKCbOk=
=E2bp
-----END PGP SIGNATURE-----
