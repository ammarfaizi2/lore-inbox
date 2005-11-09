Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbVKIWxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbVKIWxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbVKIWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:53:34 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:50506 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1161037AbVKIWxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:53:34 -0500
Message-ID: <43727E4A.3050106@tmr.com>
Date: Wed, 09 Nov 2005 17:55:06 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
References: <20051103220305.77620d8f.akpm@osdl.org>	 <20051104071932.GA6362@kroah.com>	 <1131117293.26925.46.camel@localhost.localdomain>	 <20051104163755.GB13420@kroah.com>	 <1131531428.8506.24.camel@localhost.localdomain>  <437226B2.10901@tmr.com>	 <1131557221.8506.76.camel@localhost.localdomain> <43726269.7020600@tmr.com> <1131572234.8506.130.camel@localhost.localdomain>
In-Reply-To: <1131572234.8506.130.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Rickard and Damir for reassuring me that this change is highly 
unlikely to impact any of the connection methods I use. Since PCMCIA on 
desktops and non-udev systems are uncommon, I felt the question was 
better mentioned before the patch went in. Occasionally my confiurations 
do result in a "nobody would do that" reaction.

I hope it solves your problems as well.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
