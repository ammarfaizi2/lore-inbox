Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288256AbSAQHhy>; Thu, 17 Jan 2002 02:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAQHho>; Thu, 17 Jan 2002 02:37:44 -0500
Received: from mail.mbnet.fi ([194.100.160.29]:44562 "EHLO mail.mbnet.fi")
	by vger.kernel.org with ESMTP id <S288173AbSAQHh2>;
	Thu, 17 Jan 2002 02:37:28 -0500
Message-ID: <3C468109.3090401@mbnet.fi>
Date: Thu, 17 Jan 2002 09:45:13 +0200
From: Joonas Koivunen <rzei@mbnet.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Power off NOT working, kernel 2.4.16
In-Reply-To: <3C45F45C.5000005@mbnet.fi> <20020117134753.4330b0b5.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:

> Have you checked your /etc/[rc.d/]init.d/halt script to make sure
> that it is passing the "-p" option to "halt"?  This was a change
> between the 2.0 and 2.2 kernels i.e. powerdown became separate
> from halt.


Yes, it's there, and I have also tried poweroff, no effect, last text 
line I see is 'Power down.' and the system is succefully halted, not 
switched off.

-rzei





