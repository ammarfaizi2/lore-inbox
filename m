Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUHJXjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUHJXjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267825AbUHJXjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:39:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:35515 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267818AbUHJXfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:35:22 -0400
Message-ID: <41195BC1.2030107@comcast.net>
Date: Tue, 10 Aug 2004 19:35:29 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040810)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: V13 <v13@priest.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
References: <4117D98C.2030203@comcast.net> <200408110030.37601.v13@priest.com>
In-Reply-To: <200408110030.37601.v13@priest.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



V13 wrote:
| On Monday 09 August 2004 23:07, John Richard Moser wrote:
|
|>What I found interesting was that it described bugs as
|>pseudo-quantitative based on the KLOC (thousands of lines of code) for a
|>code body.  The basic theory boils down to 5-50 bugs per 1000 LOC,
|>approaching 5 for QA audited code.  Thus, 10000 LOC executable, 50 bugs.
|
|
| I believe that you should not believe such things. They are just
statistics
| and nothing more.
|

Statistics are as a whole, not as a part.  This makes statistics a
powerful art.

| If you have a 1000 lines project and:
|
| a) Remove all empty lines means that you remove bugs?
| b) Split it to 5 libraries and 5 utilities (10 projects) means that
you'll
| have less bugs?
| c) ....
|
| I don't take generalizations like this seriously and I believe that noone
| should do. It may be true that 10.000 lines of code contain 50 bugs as an
| average of all the code that has be written so far but it doesn't mean
that:
|
| a) 50 bugs require 10.000 lines
| b) 50 bugs will always exist on 10.000 lines
| c) All the projects out there have the same number of bugs/line
|

No, but it means in a sample of one hundred and twenty eight billion
lines, there will be approximately fifty bugs per 10000 lines of code.

|
|>--John
|
| <<V13>>
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGVvBhDd4aOud5P8RAlwKAJ0Ut0XoyibvkQ9THUT1YvcoufebdwCeJmNC
PqZqaKCTrdpA2DyZydcT9Cw=
=pAJZ
-----END PGP SIGNATURE-----
