Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269815AbRHIOgn>; Thu, 9 Aug 2001 10:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269817AbRHIOgd>; Thu, 9 Aug 2001 10:36:33 -0400
Received: from camus.xss.co.at ([194.152.162.19]:55307 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S269815AbRHIOgO>;
	Thu, 9 Aug 2001 10:36:14 -0400
Message-ID: <3B729FD7.7D8BCA5F@xss.co.at>
Date: Thu, 09 Aug 2001 16:36:07 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S - *x Software + Systeme
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Dirk W. Steinberg" <dws@dirksteinberg.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <E15Ulnx-0006zZ-00@the-village.bc.nu> <3B729B96.D306185C@dirksteinberg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

"Dirk W. Steinberg" wrote:
> 
> Alan,
> 
> what you say sound a lot like a hacker solution ("check that it uses the
> right GFP_ levels"). I think it's about time that this deficit of linux
> as compared to SunOS or *BSD should be removed. Network paging should be
> supported as a standard feature of a stock kernel compile.
> 
We have swapping over NBD running for some time now on
our "xS+S Diskless Client" system, and it works really
fine! No problem running StarOffice, Netscape, The Gimp
and KDE on a 128MB Diskless Client and 250MB swap over a 
100MBit switched ethernet!

Check <http://www.xss.co.at/linux/NBD/Applications.html>
to find our solution for that.

Kernel patches are a little bit outdated, but we have NBD swap
for 2.2.19 running internally since this week, and we will
update our web-page soon.

Let us hear if it works for you.

Regards,

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
