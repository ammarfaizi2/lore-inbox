Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311960AbSCXLo7>; Sun, 24 Mar 2002 06:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312053AbSCXLot>; Sun, 24 Mar 2002 06:44:49 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:12267 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S311968AbSCXLok>; Sun, 24 Mar 2002 06:44:40 -0500
Message-ID: <3C9DBC24.1010908@ngforever.de>
Date: Sun, 24 Mar 2002 04:44:36 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Larry McVoy <lm@work.bitmover.com>, Pavel Machek <pavel@suse.cz>,
        Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de> <20020319220631.GA1758@elf.ucw.cz> <20020319152502.J14877@work.bitmover.com> <20020319233432.GS3762@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>	c) put the symlink in /tmp/installer$pid

What then about $HOME/tmp? Might be a lot less available for crackers, 
and if it doesn't exist, we create it (still as 0700).

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

