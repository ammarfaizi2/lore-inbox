Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTKCSp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTKCSp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:45:26 -0500
Received: from mout1.freenet.de ([194.97.50.132]:36075 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S262153AbTKCSpX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:45:23 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Subject: Re: How provoke call stack trace
Date: Mon, 3 Nov 2003 19:45:06 +0100
User-Agent: KMail/1.5.4
References: <3FA6A0AF.2070300@softhome.net>
In-Reply-To: <3FA6A0AF.2070300@softhome.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311031945.18864.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 03 November 2003 19:38, Ihar 'Philips' Filipau wrote:
> Hello All!
>
>     [ Simple question. Probably FAQ - but I cannot find it. ]
>
>     How can I print call stack trace, just like BUG() does?
>     But without asm(".long 0") as BUG() does.

Maybe
dump_stack();
is what you're searching for?

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/pqI9oxoigfggmSgRAscBAJ4ndlnDWL0557Jv5oE6Iawue4SEZACbBRHU
W3QGnBNgazObL2bEedaEe3A=
=FJMu
-----END PGP SIGNATURE-----

