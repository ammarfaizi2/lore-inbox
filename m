Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVAYUmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVAYUmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVAYUmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:42:19 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:11921 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262125AbVAYUlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:41:39 -0500
Date: Tue, 25 Jan 2005 15:41:12 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: wait_for_completion API extension addition
In-reply-to: <1106685023.4538.18.camel@tglx.tec.linutronix.de>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <41F6AEE8.70908@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41F6AA83.20306@sun.com>
 <1106685023.4538.18.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thomas Gleixner wrote:
> On Tue, 2005-01-25 at 15:22 -0500, Mike Waychison wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Hi Ingo,
>>
>>I noticed that the wait_for_completion API extensions made it into mainline.
>>
>>However, I posted that the patch in question is broken a while back:
>>
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=110131832828126&w=2
>>
>>Can we fix this?
> 
> 
> We reposted a fixed version. It should not be the one from October which
> made it upstream.
> 

Well, according to linux.bkbits.net/linux-2.5, it appears to have gotten
the broken version :(

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9q7odQs4kOxk3/MRAhUbAJ9jhpFbrpqi2K+lakwy9mpdwiq/3QCdHovv
16kp8J0NENFAKS/QCq6B1x4=
=NjNB
-----END PGP SIGNATURE-----
