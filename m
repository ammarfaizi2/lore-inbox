Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVAKHR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVAKHR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 02:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVAKHR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 02:17:57 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:33667 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262438AbVAKHRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 02:17:51 -0500
Message-ID: <41E37DA0.80702@comcast.net>
Date: Tue, 11 Jan 2005 02:17:52 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
References: <1105096053.5444.11.camel@ulysse.olympe.o2t>	 <20050107111508.GA6667@infradead.org> <20050107111751.GA6765@infradead.org>	 <41DEC83D.30105@comcast.net> <1105196469.10519.3.camel@localhost.localdomain>
In-Reply-To: <1105196469.10519.3.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Alan Cox wrote:
| On Gwe, 2005-01-07 at 17:34, John Richard Moser wrote:
|
|>My scheme involved a 6 month release cycle supporting kernels with
|>bugfixes for the prior 18 months (3 releases), though if you're really
|>committed to hardware driver backporting, I guess it can be done in the
|>actiwve "Stable" branch.
|
|
| 18 months is as good as supporting a seperate product line. Also you
| forgot to provide the engineering resources for your plan and to fund
| them 8)
|
|

Hello??

The latest 2.0 version of the Linux kernel is:  	2.0.40 	2004-02-08
07:13 UTC 	F 	V 	VI 	  	Changelog

You have FOUR.  2.6, 2.4, 2.2, 2.0

In my scheme it's time to let go of 2.0; support moves to 2.6, 2.4, 2.2.
~ Development goes to 2.7, in the same way the 2.6 model is done now (so
that it's always usable and needs no feature freeze etc before release).
~ In 6 months, 2.2 support is dropped, support moves to 2.8, 2.4, 2.2
with development on 2.9.  Support includes bugfixes (security and
otherwise) only.

Quick observation

|>to load up maintainers with a billion hours of backporting; but I don't
|>want to load distributors with excess work either.
|
|
| Distributors get paid by their customers to do the long term backporting
| and careful change control for big business. We take it as given that
| its -our- problem not the software developers.
|
|
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB432fhDd4aOud5P8RAqJ4AKCAEBgs7uUpQ7bTN+nI4gHWAoFfTwCfQemK
D5/IotiX+cunDFHCzhqKFkQ=
=ZBc/
-----END PGP SIGNATURE-----
