Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVG1Dsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVG1Dsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVG1Dqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:46:55 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:44644 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261283AbVG1Dql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:46:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:X-Enigmail-Supports:Content-Type:Content-Transfer-Encoding;
  b=F9LTqmvU+ethZMkaDbS60oTlWngKQvrXPYnto3BnUPpJEI3gfPmcfdiJ2doPh5Ko/F+X6rCtHChczDd8NPgyYCsxieMnUo+pCpKccp4+m1eESSSKOcFcuNUmgpZs/3XVgAT2XwvULSVXw6O6kGLJAa2yJxCsXD2FnkWYhGJV2qc=  ;
Message-ID: <42E85D27.8000607@yahoo.com.br>
Date: Thu, 28 Jul 2005 01:20:55 -0300
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>	<105c793f05072507426fb6d4c9@mail.gmail.com>	<42E59E0E.5030306@yahoo.com.br>	<20050726003322.1bfe17ee.akpm@osdl.org>	<42E7A153.6060307@yahoo.com.br> <20050727105005.30768fe3.akpm@osdl.org>
In-Reply-To: <20050727105005.30768fe3.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
>>Hi Andrew.
>>I was not able to get anything when I press this key sequence.
>>
>>I checked my sysrq key with showkey -s as this doc
>>(http://snafu.freedom.org/linux2.2/docs/sysrq.txt) says and I could
>>confirm that alt+sysrq is sending 0x54.
>>
>>I also noted that many said that this option has to be compiled in
>>kernel, but I couldn't find this option.
>>
>>Can you give me some tips?
>>
> 
> 
> (Please leave the cc list unchanged - always do reply-to-all)
> 


Oooops, sorry for that. I'm used to not send duplicate messages in reply
all.
> hm, maybe do alt-sysrq-7 to make sure that the loglevel is appropriately set.
> 
> Or do alt-sysrq-B to test that the whole sysrq thing is working.  If it is,
> that will reboot the machine.
> 
> 


Hi Andrew. No luck here :(

Indeed my laptop has two keys: Sysrq and prtScrn. I tried both and no
one worked. Am I missing something? I will do more research about it.

Thanks in advance.


- --
Regards,

Francisco Figueiredo Jr.
Npgsql Lead Developer
http://gborg.postgresql.org/project/npgsql
MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org


- -------------
"Science without religion is lame;
religion without science is blind."

                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQuhdJ/7iFmsNzeXfAQK8jQgApO7admM+5rpw4jHQ59br6qbUi07hDP0W
jl2IsAKXtyhTWeqQGLYbUbWu/4CirfwUcadrZBuUdBzn6dPTxbYSpseRKvyTTYR6
bZWH6HvlN9eEiu3VoGBN+CsQPCjZiFm/AmQJvjxaBlLi0eA6O2W1iPrkURLtE1U2
EUb4RRgtMfAv/CjMm8On8AGVUmJ6/7CabBTu2aNsQZpICga7QRUbZa1Iwkx/o5ls
y2o8rCyx/VcHMOaFxlpRDmBTvM7UwveJYA4wsNt9WQJ4kMBNJ46pDHhFDJY0zEkp
kdZJP0n3i08HCyWG6F9tqkoRhjv+9a+yrko/OByB6yIVOcWUAccO0g==
=hR7g
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
