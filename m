Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTE0UeC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTE0Uce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:32:34 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:40321 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S264126AbTE0Uap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:30:45 -0400
Message-ID: <3ED3CE5E.90709@winischhofer.net>
Date: Tue, 27 May 2003 22:45:18 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x
References: <3ED21CE3.9060400@winischhofer.net>  <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>  <3ED32BA4.4040707@winischhofer.net>  <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com> <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.55.0305271050150.2340@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Tue, 27 May 2003, Alan Cox wrote:
> 
> 
>>I'm keeping an eye on it. The correct answer appears to be
>>"use ACPI" once it works on SiS
> 
> 
> ACPI does fix it. Sadly it rock crashes my machine.

Did you try the newest patches from sf? Works like a charm in my M650 
(once I had patched my DSDT)...

>>I'll probably try some of those changes in a later -ac and see what
>>happens
> 
> 
> Are you going to take care of this for 2.4 and 2.5 Alan ?
> If yes I'd rather bail out, otherwise I'll continue to follow the 2.4 and
> 2.5 patch ..

Since this is quite important stuff I wouldn't wait for anything... we 
have the hardware, we can test it - and I don't think Alan has a 650 or 
alike for testing, right?

Thomas



-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net
mailto:twini@xfree86.org

