Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274097AbRIXSAg>; Mon, 24 Sep 2001 14:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274102AbRIXSA1>; Mon, 24 Sep 2001 14:00:27 -0400
Received: from unused ([12.150.234.220]:35071 "EHLO one.isilinux.com")
	by vger.kernel.org with ESMTP id <S274097AbRIXSAM>;
	Mon, 24 Sep 2001 14:00:12 -0400
Message-ID: <3BAF74B8.6070102@interactivesi.com>
Date: Mon, 24 Sep 2001 13:00:24 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tainting kernels for non-GPL or forced modules
In-Reply-To: <27975.1001164529@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> I have started work on the patch for /proc/sys/kernel/tainted with the
> corresponding modutils and ksymoops changes.  insmod of a non-GPL
> module ORs /proc/sys/kernel/tainted with 1, insmod -f ORs with 2.


Where can I find more information about this?  The word "tainted" doesn't 
appear in my kernel source code (I guess 2.4.2 is too old), and a search on 
google didn't reveal anything.

The reason I ask is because I'm working on a closed-source (unfortunately) 
driver for Linux, and I'd really like to make it behave as well as possible.

