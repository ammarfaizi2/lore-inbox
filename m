Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311305AbSCLSJL>; Tue, 12 Mar 2002 13:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311304AbSCLSJC>; Tue, 12 Mar 2002 13:09:02 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:2047 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S311308AbSCLSIv>; Tue, 12 Mar 2002 13:08:51 -0500
Message-ID: <3C8E442A.A52CF408@ngforever.de>
Date: Tue, 12 Mar 2002 11:08:42 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Hans Reiser <reiser@namesys.com>, James Antill <james@and.org>,
        Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote about versioning to be just fine if you remember to
handle it.
I'd suggest setting the number of versions to one by default, else we
might run into the same trouble as they did with VMS...

Thunder

-- 
begin-base64 755 -
IyEgL3Vzci9iaW4vcGVybApteSAgICAgJHNheWluZyA9CSMgVGhlIHNjcmlw
dCBvbiB0aGUgbGVmdCBpcyB0aGUgcHJvb2YKIk5lbmEgaXN0IGVpbiIgLgkj
IHRoYXQgaXQgaXNuJ3QgYWxsIHRoZSB3YXkgaXQgc2VlbXMKIiB2ZXJhbHRl
dGVyICIgLgkjIHRvIGJlIChlc3BlY2lhbGx5IG5vdCB3aXRoIG1lKQoiTkRX
LVN0YXIuXG4iICA7CiRzYXlpbmcgPX4Kcy9ORFctU3Rhci9rYW5uXAogdW5z
IHJldHRlbi9nICA7CiRzYXlpbmcgICAgICAgPX4Kcy92ZXJhbHRldGVyL2Rp
XAplIExpZWJlL2c7CiRzYXlpbmcgPX5zL2Vpbi8KbnVyL2c7JHNheWluZyA9
fgpzL2lzdC9zYWd0LC9nICA7CiRzYXlpbmc9fnMvXG4vL2cKO3ByaW50Zigk
c2F5aW5nKQo7cHJpbnRmKCJcbiIpOwo=
====
Extract this and see what will happen if you execute my
signature. Just save it to file and do a
> uudecode $file | perl
