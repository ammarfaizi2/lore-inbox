Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264229AbUFKRLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUFKRLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUFKRIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:08:42 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:4871 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S264226AbUFKRIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:08:15 -0400
In-Reply-To: <20040611165020.GC11755@wohnheim.fh-wedel.de>
References: <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com> <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com> <20040610223532.GB3340@wohnheim.fh-wedel.de> <40C91DA0.6060705@namesys.com> <20040611134621.GA3633@wohnheim.fh-wedel.de> <40C9DE9F.90901@namesys.com> <20040611165020.GC11755@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--855185660"
Message-Id: <E4784AEC-BBC9-11D8-9E92-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>,
       Dave Jones <davej@redhat.com>, Hans Reiser <reiser@namesys.com>,
       reiserfs-dev@namesys.com
From: Paul Wagland <paul@wagland.net>
Subject: Re: [STACK] >3k call path in reiserfs
Date: Fri, 11 Jun 2004 19:08:00 +0200
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-5--855185660
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed


On Jun 11, 2004, at 18:50, J=F6rn Engel wrote:

> On Fri, 11 June 2004 09:32:31 -0700, Hans Reiser wrote:
>>>
>> Reiser4 is going to obsolete V3 in a few weeks.  V3 will be retained=20=

>> for
>> compatibility reasons only, as V4 blows it away in performance.
>
> About three years ago, I switched from reiserfs to ext3.  And still, I
> have some old reiserfs partitions around that I use.  Either I'm quite
> unusual or reiser3 will stay around for a while. :)

You are not unusual at all. I switched from 2.4 kernels to 2.6 several=20=

months ago, and yet I still have production boxes running 2.2=20
kernels... Not that changing kernel code would affect me, since those=20
boxes are also running 4 year old kernels... And no, I won't tell you=20
their IP's ;-)

>> You are right though that OpenBSD does some things better.
>
> For sure.  And still, I use and develop for Linux.

It is also worth pointing out that "linux" (aka the kernel) is quite=20
different from *BSD, especially with OpenBSD, it should be more=20
properly compared to a distribution, and most distributions do run on a=20=

different release cycle than does Linus.

Cheers,
Paul

--Apple-Mail-5--855185660
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAyebwtch0EvEFvxURAjiOAJ0VYdj0nWrA9wIG++fuyl/D7ybBfwCfaGQC
fQ4d5+th2D2tuvSYy7g2LFU=
=mdDf
-----END PGP SIGNATURE-----

--Apple-Mail-5--855185660--

