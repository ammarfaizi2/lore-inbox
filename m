Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVJJTd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVJJTd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVJJTd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:33:28 -0400
Received: from imap.gmx.net ([213.165.64.20]:8152 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751125AbVJJTd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:33:27 -0400
X-Authenticated: #815327
Message-ID: <434AC201.7050904@gmx.de>
Date: Mon, 10 Oct 2005 21:33:21 +0200
From: =?UTF-8?B?TWFsdGUgU2NocsO2ZGVy?= <MalteSch@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <Trond.Myklebust@netapp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with nfs4, kernel 2.6.13.2
References: <200509251516.23862.MalteSch@gmx.de>	 <1127737730.8453.5.camel@lade.trondhjem.org>	 <200509262218.15885.MalteSch@gmx.de>  <43498432.8060503@gmx.de> <1128957945.8451.19.camel@lade.trondhjem.org>
In-Reply-To: <1128957945.8451.19.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Trond Myklebust wrote:
> su den 09.10.2005 Klokka 22:57 (+0200) skreiv Malte Schröder:
> 
>>>>>You may also want to retest with
>>>>>
>>>>>http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.13-1/linux-2.6.13-001-NFS_ALL_MODIFIED.dif
>>>>>
> I wrote all the elements in that patch so believe me, it has been
> considered. 8-)
> 
> ...however I still need to clean a few things up a bit before I'm ready
> to send it on to Andrew and Linus. Do not expect it to appear in 2.6.14,
> but rather in 2.6.15 (and possibly the 2.6.14-mm).

I have been doing some testing of 2.6.13.2 with that patch applied on
two different machines and it seems to be working :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: GnuPT 2.6.2.1 by EQUIPMENTE.DE
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDSsIB4q3E2oMjYtURAo3pAKC7+iJ8LHhV2DuOon4WxyxUtI4+UQCeNkgh
1OZUcL9q1mmSU8Xj/h2cJJc=
=s5O2
-----END PGP SIGNATURE-----
