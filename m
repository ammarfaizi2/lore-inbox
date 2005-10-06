Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVJFOrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVJFOrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbVJFOrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:47:53 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:19543 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751021AbVJFOrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:47:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=l8ji+Zv7vnV6VXRA+AAJCIKYS8TJtAVs2TCIR3hReL8nN8CdCD4mpImS1bk2pQL69fQY1u+TV80hQAVapGezrAi6FzSZnNZDRDSROtqxyy1q06yb2Ow6T83CjjP6OT7/eZHqfOhe36ECDTqdVwKpcDtv352/Ars7P9MKSoiO8Fk=
Message-ID: <43453946.3000901@gmail.com>
Date: Thu, 06 Oct 2005 17:48:38 +0300
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050822 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Poole <mdpoole@troilus.org>
CC: Emmanuel Fleury <fleury@cs.aau.dk>, linux-kernel@vger.kernel.org
Subject: Re: freebox possible GPL violation
References: <20051006120135.GA1002@linux.ensimag.fr>	<4345215B.7060708@cs.aau.dk> <87zmpm227e.fsf@sanosuke.troilus.org>
In-Reply-To: <87zmpm227e.fsf@sanosuke.troilus.org>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=D6F42CA5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Poole wrote:
> In the US, the law (17 USC 106) is very clear that renting, lending,
> and leasing are "distribution" that is a protected right.  The Berne
> Convention says the same in article 11bis (remember that a later
> revision explicitly included computer programs in "literary works").
> Do you think this interpretation of "distribution" does not apply to
> Free?  If not, why not?

The argument seems to be that you're paying for the service, and not the box,
and that the box is owned by Free and therefore no distribution occurs here, as
the kernel moves from Free to Free.

The obvious example is web servers, where you aren't distributing anything (at
least not the server software) and still providing service.

The difference here is that the box is physically at the customer's house, which
could be considered "lending", but IANAL.

Anyway, I guess you'll have to ask a (preferably French) lawyer to find out.

BTW, the whole thing about the kernel being in ROM or RAM or whatever and how it
got there are moot - its still running Linux. And if lending is distribution,
then they need to offer the source code.

FYI: Needing to reboot to change firmware makes sense, and those 10 extra
seconds might involve upgrading the proprietary firmware... But thats irrelevant.

- --
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDRTlGA7Qvptb0LKURAs9iAJ9NKgLPDkUl/BBeAMJBot0PGzIDBwCfY/SS
pxRwgjqVPlasdIPTG/kvp6U=
=uAEf
-----END PGP SIGNATURE-----
