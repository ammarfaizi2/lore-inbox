Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTEJE6E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 00:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTEJE6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 00:58:03 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:36039 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP id S261921AbTEJE6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 00:58:03 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Date: Sat, 10 May 2003 15:06:38 +1000
User-Agent: KMail/1.5.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <20030509230542.GA3267@kroah.com> <3EBC4C50.8040304@pacbell.net>
In-Reply-To: <3EBC4C50.8040304@pacbell.net>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305101506.42756.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 10 May 2003 10:48 am, David Brownell wrote:
> > s/uint32_t/u32/ please.
>
> "u32" is prettier, but is there actually a policy against using
> the more standard type names?  (POSIX, someone had said.)
Not Invented Here?

Brad
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+vIjiW6pHgIdAuOMRAm6+AKCg3P6rUZOvUEcv4emlpwXiGwAA8ACfUlLG
MuHfr7Pmc8yk017a1aWGLYw=
=8zSh
-----END PGP SIGNATURE-----
