Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVFQCWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVFQCWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 22:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFQCWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 22:22:42 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:20944
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261901AbVFQCWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 22:22:34 -0400
Message-ID: <42B225E0.1080502@linuxwireless.org>
Date: Thu, 16 Jun 2005 20:22:40 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Roland <lroland@gmail.com>
CC: Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Alejandro Bonilla <albonill@cisco.com>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
References: <4ad99e0505061605452e663a1e@mail.gmail.com>	 <42B1F5CB.9020308@g-house.de>	 <4ad99e0505061615143cc34192@mail.gmail.com>	 <42B21130.4000608@g-house.de>	 <4ad99e0505061617052f427ed6@mail.gmail.com>	 <42B218C5.9020406@linuxwireless.org> <4ad99e0505061618475716f13c@mail.gmail.com>
In-Reply-To: <4ad99e0505061618475716f13c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Roland wrote:

>On 6/17/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
>  
>
>>one question,
>>
>>    Can I know what is the problem? 
>>:I have 2 tg3 adapters, lots e100's and some Cisco PIX and devices.
>>
>>I can try to reproduce it and see if anyone has something to say about it.
>>    
>>
>
>Yes please. As I see it. Enable smtp fixup protocol on your cisco pix
>(you will need to have a smtp server to point it to), then on some
>linux system running with a kernel greater than 2.6.8.1 do a telnet to
>the smtp server that is firewalled and try to issue a smtp command.
>
>Note that cisco has a bug report on smtp fixup banner hiding issues in
>cisco os 6.3.4 but it should not result in the connection getting
>dropped, it also does not explain why this problem does not seam to
>exists on kernels prior to 2.6.9.
>
>
>Regards.
>
>Lars Roland
>  
>

Lars,

    I might be able to try this tomorrow. Just need to setup the PIX.

If you have that bug ID, let me know. ;-)

.Alejandro
