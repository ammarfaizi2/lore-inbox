Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292752AbSCOPHw>; Fri, 15 Mar 2002 10:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292780AbSCOPHm>; Fri, 15 Mar 2002 10:07:42 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:25069 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S292707AbSCOPH1>; Fri, 15 Mar 2002 10:07:27 -0500
Message-ID: <3C920E2D.2EE8845B@ngforever.de>
Date: Fri, 15 Mar 2002 08:07:25 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
CC: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck wrote:
> Thunder from the hill wrote:
> > Maybe add a config option?
> It doesn't even have to be a config option - a line
> in a header file would perfectly suffice.
So guys who don't have an idea of it won't find it. Good idea!

> Martin
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
