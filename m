Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266601AbUBGEIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 23:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266600AbUBGEHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 23:07:44 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:7915 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S266642AbUBGEHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 23:07:41 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Steve Kieu <haiquy@yahoo.com>
Subject: Re: Need help about scanner (2.6.2-mm1)
Date: Fri, 6 Feb 2004 23:07:37 -0500
User-Agent: KMail/1.6
Cc: kernel <linux-kernel@vger.kernel.org>
References: <20040207015841.36287.qmail@web10408.mail.yahoo.com>
In-Reply-To: <20040207015841.36287.qmail@web10408.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402062307.37040.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.53.166] at Fri, 6 Feb 2004 22:07:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 February 2004 20:58, Steve Kieu wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>
>Hi,
>
>Your help saved me lot of headache :-)

Thanks for the flowers.

> --- Gene Heskett <gene.heskett@verizon.net> wrote: >
>On Friday 06 February 2004 18:57, Steve Kieu
>
>wrote:
>> >-----BEGIN PGP SIGNED MESSAGE-----
>>
>> Take any device paths out of
>> the /usr/local/etc/saned/nameofyourscanner.dll
>
>just .conf ; not dll :-)

Can I plead alzheimers or something?  Working with ancient grey matter 
here.  Its working on the 70th trip around our star. :-)

>> leaving only a single [usb] as a specifier unless
>
>Yes it saved me. It work now. Why no other sane
>documentation said like yours? I think people at sane
>project should take your point to add to their
>documentation.

I don't ATM recall exactly where I first heard or read about this.

Maybe in the libusb docs?  No, not a thing, even clear back up to the 
root dir of the libusb archive.  Maybe I got it from the sane list?

In any event, thats too damned hard to find and if the libusb author 
is copying the mail here, that little detail really should be added 
to the README and/or INSTALL.libusb raw text files, or to a FAQ on 
the libusb website, the quicker of the two alternatives if this 
version of the library is stable (and it seems so to me).

The authors doc/html files are quite complete, I just read them all, 
but they attack *only* the api the programmer would use, and the 
actual non-programming user who just wants to use his scanner with 
this new-fangled system gets hung out to dry.  This question gets 
asked, and answered the same way, many times on the sane list too.

It may have been added to the sane-backend docs in a recent version, 
I'm at least one version out of date here, not being inclined to "fix 
something thats not broken" at my home site. :-)

[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
