Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267443AbUGNQMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUGNQMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267441AbUGNQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:12:35 -0400
Received: from mout0.freenet.de ([194.97.50.131]:48318 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S267443AbUGNQMX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:12:23 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [Q] don't allow tmpfs to page out
Date: Wed, 14 Jul 2004 18:11:57 +0200
User-Agent: KMail/1.6.2
References: <200407141654.31817.mbuesch@freenet.de> <200407141807.11086.mbuesch@freenet.de> <20040714160825.GA23155@devserv.devel.redhat.com>
In-Reply-To: <20040714160825.GA23155@devserv.devel.redhat.com>
Cc: William Stearns <wstearns@pobox.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407141812.00642.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Arjan van de Ven <arjanv@redhat.com>:
> yes you are;
> 
> just do 
> mount -t ramfs none /mnt/point

Oho, didn't know that. thanks. 8-}

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9VtOFGK1OIvVOP4RAkUVAJ9r+jZNnOrqvgQbUJM0hfPg310aiwCfaayJ
E9kxdYqT+06O4Vbn1xF19SA=
=yABs
-----END PGP SIGNATURE-----
