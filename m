Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280462AbRJaUAU>; Wed, 31 Oct 2001 15:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280461AbRJaUAK>; Wed, 31 Oct 2001 15:00:10 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:63364 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280459AbRJaUAC>;
	Wed, 31 Oct 2001 15:00:02 -0500
Message-ID: <3BE05841.24EC0504@pobox.com>
Date: Wed, 31 Oct 2001 12:00:02 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.3.95.1011031143513.21250A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> That's 6 extra clocks every Hz or 600 clocks per second. By the time
> you've reached the 497.1 days, you have wasted.... 0xffffffff/6 =
> 715,827,882 CPU clocks just so 'uptime' is correct?  I don't think
> so. I'd reboot.

Actually, you don't need to reboot.

The mail/dns servers I mentioned are
running fine, processing smtp and pop3
mail without a hitch, serving up dns info
for 230 dns zones, and providing ntpd
and big brother services for quite a few
other linux and linux-like systems here.

You only need to reboot if you demand
that the uptime counter be correct -

I just add 497 days for now....

cu

jjs


