Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUESUE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUESUE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbUESUE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:04:27 -0400
Received: from mout0.freenet.de ([194.97.50.131]:40685 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S264512AbUESUE0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:04:26 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Jaco Kroon <jkroon@cs.up.ac.za>
Subject: Re: Kernel BUG at slab.c:1930
Date: Wed, 19 May 2004 22:04:00 +0200
User-Agent: KMail/1.6.2
References: <40AB3643.7000602@cs.up.ac.za>
In-Reply-To: <40AB3643.7000602@cs.up.ac.za>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405192204.00926.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 19 May 2004 12:26, you wrote:
> Here is the oops (written off and typed up), unfortunately I don't know 
> how to convert this to nicely readable symbols ...

There's a tool called ksymoops to decode the symbols.
You can find it on kernel.org

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAq72wFGK1OIvVOP4RAgyVAJ42EI1AM6G3WY0SbbaPimc2BdGFBgCgsh/W
imxw2KsODnNqUS66P64QiPk=
=GBVq
-----END PGP SIGNATURE-----
