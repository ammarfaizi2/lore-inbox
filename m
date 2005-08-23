Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVHWPJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVHWPJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVHWPJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:09:00 -0400
Received: from mxsf35.cluster1.charter.net ([209.225.28.160]:19392 "EHLO
	mxsf35.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932189AbVHWPI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:08:59 -0400
X-IronPort-AV: i="3.96,135,1122868800"; 
   d="scan'208"; a="1303233729:sNHT17540642"
Message-ID: <430B3BEC.7080703@samba.org>
Date: Tue, 23 Aug 2005 10:08:28 -0500
From: "Gerald (Jerry) Carter" <jerry@samba.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>, Steven French <sfrench@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Urban.Widmark@enlight.net, samba@samba.org,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [Samba] Re: New maintainer needed for the Linux smb filesystem
References: <OF200CE886.6A353FBA-ON87257065.0005812F-86257065.0005B594@us.ibm.com> <43094206.3070602@samba.org> <Pine.LNX.4.58.0508230907150.6680@wombat.indigo.net.au>
In-Reply-To: <Pine.LNX.4.58.0508230907150.6680@wombat.indigo.net.au>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ian Kent wrote:
> On Sun, 21 Aug 2005, Gerald (Jerry) Carter wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Steven French wrote:
>>|
>>| We are close, but not quite ready to disable smbfs.
>>
>>Steve,
>>
>>I have been itching to work on some kernel code.
>>If you need someone just to keep things afloat,
>>I'd been happy to look into it.  There would be some
>>start up time of course.  If you would be willing to
>>help me navigate the things other than code, it
>>shouldn't be that big of a deal.
> 
> I wouldn't mind helping out here either.  Perhaps a joint 
> effort Jerry?

That's fine by me.

Steve, I'll touch base with on #samba-technical to work out
what to do first.  I know we have had a lot of reports
on https://bugzilla.samba.org/ that were originally closed
as invalid since were weren't supporting the kernel smbfs code
at that time.






cheers, jerry
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDCzvsIR7qMdg1EfYRAga/AKCTUZpLIL6oUrpg5gOiPOc80e3KjQCeNv0I
XKnUztDUIKyR+3uon+ofKB4=
=BwsH
-----END PGP SIGNATURE-----
