Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTE0Wdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTE0Wdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:33:50 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:64897 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S264414AbTE0Wdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:33:47 -0400
Message-ID: <3ED3EB21.1090606@winischhofer.net>
Date: Wed, 28 May 2003 00:48:01 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Davide Libenzi <davidel@xmailserver.org>, Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x
References: <3ED21CE3.9060400@winischhofer.net>	 <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>	 <3ED32BA4.4040707@winischhofer.net>	 <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com>	 <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk>	 <3ED3CDA9.5090605@winischhofer.net> <1054068660.19108.15.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-05-27 at 21:42, Thomas Winischhofer wrote:
> 
>>Alan Cox wrote:
>>
>>>I'm keeping an eye on it. The correct answer appears to be 
>>>"use ACPI" once it works on SiS
>>
>>It already does. No problem, except for idiotic OS string checks which 
>>require using a custom DSDT.
> 
> 
> It only works for setups that choose not to use the APIC in the ACPI
> setup. I know how to fix it (indeed I fixed 2.5 ages ago with info from
> Ollie)

Granted. I have APIC disabled here.... (and never tried otherwise)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net
mailto:twini@xfree86.org

