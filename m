Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUALX3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUALX3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:29:22 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:10710 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S263792AbUALX3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:29:19 -0500
Date: Mon, 12 Jan 2004 18:28:39 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <20040112225023.GA21399@hockin.org>
To: Tim Hockin <thockin@hockin.org>
Cc: raven@themaw.net, Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <40032DA7.8050000@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig788D76FBBCA3F1090DD4A463;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
 <40029C19.409@sun.com> <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
 <4002CAB6.3000800@sun.com> <20040112225023.GA21399@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig788D76FBBCA3F1090DD4A463
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tim Hockin wrote:

>On Mon, Jan 12, 2004 at 11:26:30AM -0500, Mike Waychison wrote:
>  
>
>>/usr   /man1   server:/usr/man1   \
>>         /man2   server:/usr/man2
>>
>>is the same as the two distinct entries:
>>
>>/usr/man1   server:/usr/man1
>>/usr/man2   server:/usr/man2
>>
>>Now that I think about it, the discussion in my proposal paper about 
>>multimounts with no root offsets probably isn't required.
>>    
>>
>
>The latter requires /usr/man1 and /usr/man2 to exist.  The former only
>requires /usr to exist, right?
>
>  
>
Traditionally, the automount system is allowed to create directories as 
needed.


-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enig788D76FBBCA3F1090DD4A463
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAAy2ndQs4kOxk3/MRApKuAJwIIty8W5ZigLpLxBPPZECLrC2JCQCghWYO
60hir2yXhTXrl4XMqW4hzXs=
=9vNr
-----END PGP SIGNATURE-----

--------------enig788D76FBBCA3F1090DD4A463--

