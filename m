Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbTIHVzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTIHVzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:55:32 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:9187 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S263701AbTIHVz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:55:28 -0400
Date: Mon, 08 Sep 2003 17:55:10 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Use of AI for process scheduling
In-reply-to: <3F5CD863.4020605@techsource.com>
To: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200309081755.19777.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.3
References: <3F5CD863.4020605@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I think that this makes sense. It would definitely help with designing the 
perfect scheduler. One thing tho, I wouldn't use kgdb or any other debugger, 
instead I would say that /proc or /sys interface would make more sense. 
Simply copy the weights somewhere else, dissect them, and then act 
accordingly.

Jeff.

- -- 
A computer without Microsoft is like chocolate cake without mustard.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/XPrCwFP0+seVj/4RAvopAJ0VvG9Z+nxl6Tr+0Ry9pgHXBPmOXgCffalk
wJujLlpHTWGzehMRKmcBw9s=
=awXk
-----END PGP SIGNATURE-----

