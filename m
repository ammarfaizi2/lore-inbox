Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281165AbRLQQWj>; Mon, 17 Dec 2001 11:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbRLQQWa>; Mon, 17 Dec 2001 11:22:30 -0500
Received: from ns.suse.de ([213.95.15.193]:15885 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281165AbRLQQWO> convert rfc822-to-8bit;
	Mon, 17 Dec 2001 11:22:14 -0500
Date: Mon, 17 Dec 2001 17:22:14 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20011217170740.74a1cb95.sebastian.droege@gmx.de>
Message-ID: <Pine.LNX.4.33.0112171717010.28670-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Sebastian Dröge wrote:

> Attached you find my .config, lspci -vvv and dmesg output
> I'll test 2.4.17-rc1 in a few minutes and will report what happens ;)

Thanks. Right now getting 2.4 into a better shape is more
important than fixing 2.5, so if you find any problems repeatable
in 2.4.17rc1, Marcelo really needs to know about it.

The only USB changes in my tree are __devinit_p changes, which
really shouldn't be causing a problem, but there could be some
other unrelated-to-usb patch which is causing this..

2.4 info would be appreciated.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

