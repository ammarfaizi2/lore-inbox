Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWEARxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWEARxm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWEARxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:53:42 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:53774 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S932184AbWEARxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:53:41 -0400
Message-ID: <44564B34.6020109@gmail.com>
Date: Mon, 01 May 2006 19:53:33 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, penberg@cs.helsinki.fi, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] minix filesystem update to V3 diffed to 2.6.17-rc3
References: <44560796.8010700@gmail.com> <20060501100328.37527eb2.akpm@osdl.org> <4456430C.2040806@gmail.com>
In-Reply-To: <4456430C.2040806@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel Aragonés napsal(a):
> Hi Andrew,
> 
> Well, I don't know how to solve it. If I don't allocate with kmalloc,
> the compiler stops with error. If I free memory with kfree instead of
> setting offset = NULL, an exception is produced.
Ok, which error?

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEVks0MsxVwznUen4RAtfpAJ4i+UT6oK2juNxRy1cUH+hJK1JpFACfftk9
6e1qvdAzp9sXduHNKo/5/lI=
=LfQg
-----END PGP SIGNATURE-----
