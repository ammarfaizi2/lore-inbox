Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268720AbUI2RAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268720AbUI2RAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUI2RAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:00:19 -0400
Received: from camus.xss.co.at ([194.152.162.19]:16915 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S268710AbUI2RAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:00:05 -0400
Message-ID: <415AE9CF.40008@xss.co.at>
Date: Wed, 29 Sep 2004 18:58:55 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: "Miller, Mike (OS Dev)" <mike.miller@hp.com>,
       Christoph Hellwig <hch@infradead.org>, mikem@beardog.cca.cpqcorp.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       "Baker, Brian (ISS - Houston)" <brian.b@hp.com>
Subject: Re: patch so cciss stats are collected in /proc/stat
References: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net> <1096476186.2786.45.camel@laptop.fenrus.com>
In-Reply-To: <1096476186.2786.45.camel@laptop.fenrus.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arjan van de Ven wrote:
> On Wed, 2004-09-29 at 18:29, Miller, Mike (OS Dev) wrote:
>
>
>>>This patch has been reject about half a million times, why are people
>>>submitting it again and again?
>>
>>As I said in my mail, it's a customer driven issue. As long as customers rely on /proc/stat we'll keep trying. You can't tell a customer how he/she should be doing things on their systems.
>
>
> I doubt you have many customers using 2.4.28.... I suspect that by now
> the majority of people is either using an (ancient) 2.4 vendor kernel or
> a 2.6 kernel. The very low number of reports on lkml about 2.4 seems to
> confirm that ...

"25% of accidents are caused by drunken drivers. That means
75% of accidents are caused by drivers which did not drink.
So why keep people complaining about alcohol and driving?"

Is that what you mean? You must be kidding!

The majority of _our_ customers are using 2.4.x kernels
(x beeing in the range from 19 to 28pre3) and it looks like
it will stay that for quite a while...

- - andreas

PS: I know this is somewhat off topic, but I just want to raise
my voice if I get the impression kernel developers forget about
the "real world outside". I will shut up in a moment! Thank you!

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBWum9xJmyeGcXPhERArzMAKCYhHvVvwpFObCzrPby2qY9u9MURQCgrelJ
BpeZ2tG8zw0po/5ByYKFuZk=
=RlQc
-----END PGP SIGNATURE-----

