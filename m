Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132836AbRDDPZb>; Wed, 4 Apr 2001 11:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132839AbRDDPZV>; Wed, 4 Apr 2001 11:25:21 -0400
Received: from staffnet.com ([207.226.80.14]:60170 "EHLO staffnet.com")
	by vger.kernel.org with ESMTP id <S132836AbRDDPZM>;
	Wed, 4 Apr 2001 11:25:12 -0400
Message-ID: <3ACB3CA5.D978EF41@staffnet.com>
Date: Wed, 04 Apr 2001 11:24:21 -0400
From: Wade Hampton <whampton@staffnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
In-Reply-To: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com> <20010403202127.A316@bacchus.dhis.org> <3ACB2323.C1653236@mips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Langgaard wrote:
> 
> I'm not sure what the problem is, but the whole deal about checking whether the
> controller runs in 16 bit or 32 bit mode, is a little bit tricky.
>[snip]
Without the changes listed in this thread, 2.4.3 crashed vmware 2.0.3 
Linux. It did not OOPS the kernel, it caused vmware to go down in
flames....  Changing the code per the previous mail fixed it and
my VM now works fine.  THANKS!

Is this list non-causal?  The answer was posted to the list as I
was getting ready to build 2.4.3 on my VM, before I found the 
problem or even had to ask the question!

Cheers,
-- 
W. Wade, Hampton  <whampton@staffnet.com>  
If Microsoft Built Cars:  Every time they repainted the 
lines on the road, you'd have to buy a new car.
Occasionally your car would just die for no reason, and 
you'd have to restart it, but you'd just accept this.
