Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272367AbTHIOfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272375AbTHIOfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:35:37 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:33396
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272367AbTHIOfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:35:33 -0400
Message-ID: <3F3509C0.9050403@rogers.com>
Date: Sat, 09 Aug 2003 10:48:32 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
CC: preining@logic.at, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
References: <3F34D0EA.8040006@rogers.com> <Pine.LNX.4.56.0308091030590.16795@filesrv1.baby-dragons.com>
In-Reply-To: <Pine.LNX.4.56.0308091030590.16795@filesrv1.baby-dragons.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.102.238.105] using ID <dw2price@rogers.com> at Sat, 9 Aug 2003 10:34:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not a lilo issue (ie. I use grub) I ran into the issue when I first 
started with the 2.6.0 series test kernels.


Mr. James W. Laferriere wrote:
> 	He3llo Gaxt ,  Is this change to the lilo.conf funtionality
> 	documented someplace ?  It is not in the halloween-2.5 document .
> 		Tia ,  JimL
> 
> On Sat, 9 Aug 2003, gaxt wrote:
> 
>> > I am trying 2.6.0-test3 but cannot get the kernel to mount /dev/hdb1
>> > which is the root fs.
>>Try changing in your bootloader root=/dev/hdb1 to root=341


