Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTB1VNB>; Fri, 28 Feb 2003 16:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTB1VNB>; Fri, 28 Feb 2003 16:13:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:54537 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263333AbTB1VNA>;
	Fri, 28 Feb 2003 16:13:00 -0500
Date: Fri, 28 Feb 2003 13:14:41 -0800
From: Greg KH <greg@kroah.com>
To: kernel1@jsl.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Keyspan USB/Serial Drivers for 2.4.20/2.4.21-pre4
Message-ID: <20030228211441.GC29266@kroah.com>
References: <20030221000647.GA26468@kroah.com> <200302211728.h1LHSS720755@jsl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302211728.h1LHSS720755@jsl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 09:28:28AM -0800, System Administrator wrote:
> 
> Please excuse my mistakes.  That was my very first post to the list even
> though I've been reading it for many years.  I wasn't entirely sure how to
> get this out there.  I'm glad you noticed it Greg :)
> 
> You're right.  the Config.in file didn't need all those changes.  I mistakedly
> diffed against the wrong file.
> 
> The 49WLC device works fine with this patch.  I have not tested the MPR but
> it should work too.
> 
> Below is a better patch.

Thanks, I've applied this patch (and the firmware files) to my 2.4 and
2.5 trees, and will be sending them onward soon.

greg k-h
