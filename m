Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVA2SKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVA2SKV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVA2SKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:10:21 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:43162 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261529AbVA2SKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:10:14 -0500
Message-ID: <41FBD1AE.2080608@comcast.net>
Date: Sat, 29 Jan 2005 13:10:54 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jakub Jelinek <jakub@redhat.com>, Rik van Riel <riel@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <41F95F79.6080904@comcast.net> <1106862801.5624.145.camel@laptopd505.fenrus.org> <41F96C7D.9000506@comcast.net> <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com> <41FB2DD2.1070405@comcast.net> <20050129173704.GM11199@devserv.devel.redhat.com> <41FBCC91.8010602@comcast.net> <20050129175549.GA2846@infradead.org>
In-Reply-To: <20050129175549.GA2846@infradead.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Christoph Hellwig wrote:
> On Sat, Jan 29, 2005 at 12:49:05PM -0500, John Richard Moser wrote:
> 
>>>The ideas in IBM's ProPolice changes are good and worth
>>>implementing, but the current implementation is bad.
>>>
>>
>>Lies.  I've read the paper on the current implementation, it's
>>definitely good.  It only operates on C/C++ code though, but that's the
>>scope of it.
> 
> 
> Yeah, I guess your extensive compiler internals experience and knowledge
> of gcc internals weights a lot more than the opinion of the gcc team..
> 

I read "implementation" as "the way it's implemented," not as "the
quality of the code."

Did I miss the target?  *Aims in the other direction then?*

> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+9GthDd4aOud5P8RAm/FAJwNvbrxPP8fcJmMM//vcYL10nMXTACggi57
jOKfS4FU1sdPL7AjKRgMmBg=
=igR0
-----END PGP SIGNATURE-----
