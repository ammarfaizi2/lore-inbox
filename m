Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272059AbRIDSLS>; Tue, 4 Sep 2001 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272061AbRIDSLJ>; Tue, 4 Sep 2001 14:11:09 -0400
Received: from jive.SoftHome.net ([204.144.231.93]:39112 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S272059AbRIDSLC>;
	Tue, 4 Sep 2001 14:11:02 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Rik van Riel <riel@conectiva.com.br>
Date: Tue, 4 Sep 2001 14:10:34 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[06]: Question Re AC Patch with VM Tuneable Parms for now
Reply-to: jlmales@softhome.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3B94E0DA.7779.4C5A95@localhost>
In-Reply-To: <3B943CB0.14656.754C73@localhost>
In-Reply-To: <Pine.LNX.4.33L.0109041347370.7626-100000@imladris.rielhome.conectiva>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rik,

Thanks for taking the time to reply.

The URL you noted was most helpful in how the VM Tuneable parameters
can be set with the AC7 patch.

Correct me if I am wrong, but I sense the respective patches were not
implemented until 2.4.9-ac4, or were they implemented once before in
the noted 2.4.8-ac7 patch and I just did not understand the details
of the changes?

Follow up question re "A patch against kernel 2.4.8-ac7 has been
created which allows you to play with page aging strategies as well
as setting a static inactive target and switch drop_behind on and
off. The page aging strategies are:"

Where is the "static inactive target and switch drop_behind on and
off" items explained, and how are these set?


Regards,

John L. Males
Willowdale, Ontario
Canada
04 September 2001 14:10
mailto:jlmales@softhome.net


Date sent:      	Tue, 4 Sep 2001 13:48:33 -0300 (BRST)
From:           	Rik van Riel <riel@conectiva.com.br>
To:             	"John L. Males" <jlmales@softhome.net>
Copies to:      	<linux-kernel@vger.kernel.org>
Subject:        	Re: Question Re AC Patch with VM Tuneable Parms for
now

> On Tue, 4 Sep 2001, John L. Males wrote:
> 
> > Can someone advise me if the "Make several vm behaviours tunable
> > for now" as of the 2.4.9-ac4 patch are implemented in the kernel
> > .config file?
> 
> Some info can be found on
> http://linux-mm.org/wiki/moin.cgi/PageAging (IIRC, but could also
> be another page on the wiki).
> 
> cheers,
> 
> Rik
> -- 
> IA64: a worthy successor to i860.
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
> 


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO5UnG+AqzTDdanI2EQJOxQCg/ODHhHWEMWHHjdxIXjvhr+jEhlIAoOcb
53/To7k7U/819riBMCKV5wZU
=aazG
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
