Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292396AbSBUOxv>; Thu, 21 Feb 2002 09:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292402AbSBUOxm>; Thu, 21 Feb 2002 09:53:42 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:25058 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S292396AbSBUOxd>;
	Thu, 21 Feb 2002 09:53:33 -0500
Message-ID: <3C75092C.8020508@debian.org>
Date: Thu, 21 Feb 2002 15:50:20 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: David Lang <david.lang@digitalinsight.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, andersen@codepoet.org,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <fa.hp69onv.i7qtq3@ifi.uio.no> <fa.lqt3hav.190o1i9@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2002 14:53:30.0907 (UTC) FILETIME=[870CF6B0:01C1BAE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:

> 
> 2. does it handle the 'I want this feature, turn on everything I need for
> it'?
> 
> 3. if it handles #2 what does it do if you turn off that feature again
> (CML2 turns off anything it turned on to support that feature, assuming
> nothing else needs it)


These are tools dependent and not language dependent.
Please split the two problem: the language and the configuration
tools.

	giacomo

 


