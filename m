Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUJJSpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUJJSpO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 14:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268425AbUJJSpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 14:45:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:11753 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268436AbUJJSpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 14:45:07 -0400
Message-ID: <4169833C.4070006@comcast.net>
Date: Sun, 10 Oct 2004 14:45:16 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20041001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <41677E4D.1030403@mvista.com>  <4169293B.3020502@comcast.net> <1097429214.1427.14.camel@krustophenia.net>
In-Reply-To: <1097429214.1427.14.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Lee Revell wrote:
| On Sun, 2004-10-10 at 08:21, John Richard Moser wrote:
|
|
|>Does any of this 'work' on x86_64 yet?  I heard that Ingo's voluntary
|>pre-empt was x86 only and didn't work on amd64; this stuff's kinda new,
|>does it work outside x86 yet?
|>
|>I'd like to see what these kinds of things do.  :)
|
|
| The VP patches currently work on x86, x64, amd64, and ppc AFAIK.  As
| stated in the docs, the MontaVista stuff is x86 only right now.

Is there a stable amd64 voluntary pre-empt patch for 2.6.7?  I'm using
PaX so I can't go up until the author catches up to the new VM changes
introduced in 2.6.8+.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBaYM7hDd4aOud5P8RAl9tAJ9mJmKtt4p+I4iLh9u1hiFQXK1DlwCfbBhL
TTXwLyxVxwBNuZvnpfj5BN8=
=tbRd
-----END PGP SIGNATURE-----
