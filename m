Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSHCMho>; Sat, 3 Aug 2002 08:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317566AbSHCMho>; Sat, 3 Aug 2002 08:37:44 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:16867 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S317561AbSHCMho>; Sat, 3 Aug 2002 08:37:44 -0400
Message-ID: <3D4BCF5A.7080904@Synopsys.COM>
Date: Sat, 03 Aug 2002 14:40:58 +0200
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19
References: <Pine.LNX.4.44.0208030631580.5119-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi T.

Thunder from the hill wrote:
> Hi,
> 
> On Sat, 3 Aug 2002, Harald Dunkel wrote:
> 
>>PS: After booting 2.4.19 'depmod -a' works as expected, but
>>     'depmod -ae -F /boot/System.map-2.4.19 2.4.19' doesn't. I
>>     would guess its a problem with depmod.
> 
> 
> I'd rather guess the problem is that you didn't make dep after config 
> changes. Read the FAQ, please.

Of course 'make dep' was in. But Debian includes modutils 2.4.15. After
upgrading to 2.4.19 the problem is gone. Debian is out of date :-(.

Maybe it would help to update Documentation/Changes to list the new
modutils, too?


Regards

Harri

