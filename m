Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbUCPQvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUCPQtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:49:11 -0500
Received: from mout2.freenet.de ([194.97.50.155]:31928 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S263124AbUCPQjN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:39:13 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Timothy Miller <miller@techsource.com>
Subject: Re: -O3.... again
Date: Tue, 16 Mar 2004 17:38:57 +0100
User-Agent: KMail/1.6.50
References: <40572C09.5080208@techsource.com>
In-Reply-To: <40572C09.5080208@techsource.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403161739.08663.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 16 March 2004 17:32, you wrote:
> Anyone experiment with this?  Any thoughts?

Some time ago I experimented with some crazy (tm)
optimization values.
http://marc.theaimsgroup.com/?l=linux-kernel&m=104655063413152&w=2

As you can see -O3 broke ide-scsi for me. I don't know
the reason for it and I don't know if this applies to
recent kernels, too.

So it is possible to break stuff with -O3

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVy2rFGK1OIvVOP4RAm9mAJ9zK3OiDsJmUXaaEygxikR034Rv9ACfXlaB
cAQ/IoX7wzxUNaOB+1LtYxE=
=0inF
-----END PGP SIGNATURE-----
