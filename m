Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWFWNVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWFWNVI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWFWNVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:21:08 -0400
Received: from etna.obsidian.co.za ([196.36.119.67]:39868 "EHLO
	etna.obsidianonline.net") by vger.kernel.org with ESMTP
	id S1751441AbWFWNVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:21:06 -0400
Message-ID: <449BEABD.5010305@rootcore.co.za>
Date: Fri, 23 Jun 2006 15:21:01 +0200
From: Charles Majola <chmj@rootcore.co.za>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, stephen@blacksapphire.com,
       benm@symmetric.co.nz, kernel list <linux-kernel@vger.kernel.org>,
       radek.stangel@gmsil.com
Subject: Re: IPWireless 3G PCMCIA Network Driver and GPL
References: <20060616094516.GA3432@elf.ucw.cz>	 <20060623124405.GA8027@elf.ucw.cz> <1151068832.4549.7.camel@localhost.localdomain>
In-Reply-To: <1151068832.4549.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-06-23 am 14:44 +0200, ysgrifennodd Pavel Machek:
>   
>> combination for a month, I guess I should be able to get it going in
>> 2.6.16, and I should be able to get it into shape for mainline, too...
>>     
>
> Main thing is probably the tty driver changes, those are fairly easy to
> do and should cleanup pretty fast. 
>   
I have the card and the drivers working with 2.6.12 (Ubuntu Breezy) 
also, I can help update and test
 it. I'm actually due it get it working with Dapper (2.6.15) in the near 
future.

Alan, can you please give me pointers on the tty changes since 2.6.12?

--
chmj
