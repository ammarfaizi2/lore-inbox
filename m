Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752258AbWJNXvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbWJNXvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 19:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbWJNXvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 19:51:52 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:2966 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1752257AbWJNXvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 19:51:51 -0400
Message-ID: <45317814.8000709@comcast.net>
Date: Sat, 14 Oct 2006 19:51:48 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kevin K <k_krieser@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: Driver model.. expel legacy drivers?
References: <4530570B.7030500@comcast.net>	 <20061014075625.GA30596@stusta.de> <4530FC8E.7020504@comcast.net>	 <7E4CA247-AD0A-4A20-BEAF-CDD2CA4D3FFE@sbcglobal.net>	 <45315A20.6090600@comcast.net> <1160870637.5732.46.camel@localhost.localdomain>
In-Reply-To: <1160870637.5732.46.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Alan Cox wrote:
> Ar Sad, 2006-10-14 am 17:44 -0400, ysgrifennodd John Richard Moser:
>> Yeah, a static code coverage analyzer or some sort of code-reducer would
>> be nice; these are in general pipe dreams but eh.  Also these are
>> compressed bzip2 tarball sizes, not compiled kernel sizes or source tree
>> sizes.  I would imagine a 100MB bzip2 would turn into something quite
>> large; the major issue is the amount of work it takes to maintain
>> something like that.
> 
> It's not actually clear that you can sensibly evaluate trends like that
> or the maintainability. Take a look at the flamewar the day the kernel
> tarball stopped fitting on one floppy disk (1.44MB)
> 

I was using something called DOS back then I think....

> Things ceasing to be maintained and exiting the kernel is a two step
> process and there is a lot in the "waiting for someone to rescue it"
> stage that probably has no remaining users. At some point nor far away
> there is going to be a big flush of drivers when ISA bus is dropped.
> 

WOW that means I'll lose networking on my other machine, which uses a
D-Link on an ISA bus to power a Pentium 200MHz with MMX technology.

> Microsoft are also being very helpful. They are making it harder and
> harder for people to use drivers not microsoft-signed which in turns
> pushes up costs for development and as a result encourages more
> standardization of driver interfaces to take place.

huh?

> 
> Alan
> 
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTF4EAs1xW0HCTEFAQK1tg/9Gbhv3XM6viYCHWj+XPfyZ4QTNdQ4EPgO
h9V3lU34PZdq65NOwIyqMPx+QeMAH3YQiyR5hyplYLzkE9/bZCe+xjLL2YTOx/C8
N0BvGTHCIgqhiTWOu1/3nE7R6sPnMUh2dgBDcHdfHFIGJfcVAVYL5XiOvJEL/85a
3pl1P3OUxVhTgCZTAGHI0NDOyt8IRMVyGy8QbInNpfLHrF14qApEK4Blx9M+SKou
QRGIgjm1RusjdEHn2kIE0AWNHl3niVLfWCIies611pqiPUiwr/eztmrGzt0/XuwZ
LYBitpSsHPH16s8eIWijGev7I42aN3q+wwoKB/2BwzqHSXvpJ9W+I1Q1rsmvrOa9
7OkyrwGss4VTJawKPiyqzV00XZjhTpLqAuRePwG8zt8Usor8P6DYxl/4cHYklOH1
uH2qSCxVK2nX9V20NVvDfnpNya5aFMe7HVzWPcigASk1KJak1VneNiotX2FenwpM
i15wjBe7V8Vxj+WXa0cG1NFBUXx9jnrSu44BqeuO/rMCJ9vS0P0eHxv2Z9wD7WRn
0vC1nQ5w2FyJzaev5Nh4CprasOaZR/MoUlL5W95/jUIGxak4xr7Hhs8yi9QSd1rJ
w8rHmtz5CKH33FqYZgsaOwDQjm9MleY+O9+i+RejCneSRxBT8FjHvy6gvJ+DypSZ
t1QJ4gkK5MI=
=lsV7
-----END PGP SIGNATURE-----
