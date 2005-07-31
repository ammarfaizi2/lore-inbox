Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVGaV6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVGaV6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 17:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVGaV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 17:57:34 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:61582 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261962AbVGaV5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 17:57:33 -0400
Message-ID: <42ED4949.3080500@andrew.cmu.edu>
Date: Sun, 31 Jul 2005 17:57:29 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>	 <1122678943.9381.44.camel@mindpipe>	 <20050730120645.77a33a34.Ballarin.Marc@gmx.de>	 <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz>	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>	 <42ED32D3.9070208@andrew.cmu.edu>  <20050731211020.GB27433@elf.ucw.cz> <1122846092.13000.4.camel@mindpipe>
In-Reply-To: <1122846092.13000.4.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
 > On Sun, 2005-07-31 at 23:10 +0200, Pavel Machek wrote:
 >>[But we
 >>probably want to enable ACPI and cpufreq by default, because that
 >>matches what 99% of users will use.]
 >
 > Sorry, this is just ridiculous.  You're saying 99% of Linux
 > installations are laptops?  Bullshit.

I believe he's talking about the future (he did said "will").  All the 
new AMD64 desktop chips have powersaving now, and Intel chips either 
have it now or will soon.  With the power that desktop chips draw 
nowadays (some are 80+ watts at idle), it is an important consideration. 
  As for uptake, a realistic number would be probably be 90% in three years.

Of course regardless of that I'd still like to keep the 1msec sleep 
resolution...

  - Jim
