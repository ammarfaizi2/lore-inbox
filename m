Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUBLS1g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUBLS1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:27:36 -0500
Received: from mout0.freenet.de ([194.97.50.131]:5587 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S266522AbUBLS1d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:27:33 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Michael Frank <mhf@linuxmail.org>
Subject: Re: lock up with 2.4.23
Date: Thu, 12 Feb 2004 19:27:18 +0100
User-Agent: KMail/1.6.50
References: <Pine.LNX.4.58.0402111939370.5221@potato.cts.ucla.edu> <200402121634.32186.mbuesch@freenet.de> <200402130119.58662.mhf@linuxmail.org>
In-Reply-To: <200402130119.58662.mhf@linuxmail.org>
Cc: Chris Stromsoe <cbs@cts.ucla.edu>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402121927.25426.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 12 February 2004 18:19, you wrote:
> You say your drivers are not that bad, OK, the kernel is not 
> that bad too.

Yea, I know. :) It ran months over months without
problems, now.

> Now, please consider that this mainboard is about 10 years old.
> How old is the PSU?

PSU? What's that?

> Consider whether the ambient temperature was higher than average
> at time of lockup.
> 
> Please check:
> 
> 1) CPU heatsink contaminated
> 2) CPU fan bad
> 3) PSU fan bad or contaminated (also PSU slots/fins)
> 4) Power supply instabel due to capacitors drying out
> 5) Mainboard CPU voltage instable due to capacitors drying out
> 6) Bad contacts at memory modules
> 7) Coroded PSU or other connectors
> 
> ... Just some of the things I have encountered
> 
> Bottom line: its HW!

Yes, it could be. We'll see. I try to catch the next
oops (if there is one).

> Your mail is helpful ;)

Sorry for my bad english. ;)

> Michael

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAK8WMFGK1OIvVOP4RAn5LAKCKt+nb/rdAk/x25lFpbZQdGxD/HwCcDxAK
vZImv3Jz4da1gKzUtOf4/Rk=
=8elT
-----END PGP SIGNATURE-----
