Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129693AbRBTKBE>; Tue, 20 Feb 2001 05:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRBTKAz>; Tue, 20 Feb 2001 05:00:55 -0500
Received: from cs.columbia.edu ([128.59.16.20]:24008 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129693AbRBTKAl>;
	Tue, 20 Feb 2001 05:00:41 -0500
Date: Tue, 20 Feb 2001 02:00:31 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: CaT <cat@zip.com.au>
cc: <linux-kernel@vger.kernel.org>, Dragan Stancevic <visitor@valinux.com>,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: eepro100 + 2.2.18 + laptop problems
In-Reply-To: <20010220184028.A503@zip.com.au>
Message-ID: <Pine.LNX.4.30.0102200156090.1971-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, CaT wrote:

> > patched, old removed, new installed, waiting for fubar. :)
> 
> Ok. this is what I got in my kern.log. this is on a fresh reboot.
> 
> Feb 20 18:31:49 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
> Feb 20 18:31:49 theirongiant kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!
> Feb 20 18:31:49 theirongiant kernel: eepro100: cmd_wait for(0xffffff90) timedout with(0xffffff90)!
> Feb 20 18:32:21 theirongiant last message repeated 29 times
> Feb 20 18:33:15 theirongiant last message repeated 31 times

Are you sure this driver has my patch applied? There is no way you could 
have gotten these messages without getting the other printk as well..

Can you check it again, please?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

