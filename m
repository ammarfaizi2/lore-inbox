Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTKPQ7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 11:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTKPQ7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 11:59:06 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:49670 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S263014AbTKPQ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 11:58:10 -0500
Message-ID: <3FB7AC9E.5020502@dcrdev.demon.co.uk>
Date: Sun, 16 Nov 2003 16:58:06 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Re: Hard lock on 2.6-test9]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-------- Original Message --------
Subject: 	Re: Hard lock on 2.6-test9
Date: 	Sun, 16 Nov 2003 13:33:32 +0000
From: 	Dan Creswell <dan@dcrdev.demon.co.uk>
To: 	Davide Libenzi <davidel@xmailserver.org>
References: 
<Pine.LNX.4.44.0311151501000.1997-100000@bigblue.dev.mdolabs.com>



Davide Libenzi wrote:

>On Sat, 15 Nov 2003, Dan Creswell wrote:
>
>  
>
>>Chipset is E7505 with dual Xeons.
>>
>>Under X, I can provoke a lock just by waggling the mouse.  I've had the 
>>machine connected up to a serial console with nmi_watchdog=1 and, when 
>>the machine dies, nothing is printed on the console (I guess that makes 
>>it *very* bad :( ).
>>    
>>
>
>Is NMI really enabled?
>
>$ cat /proc/interrupts
>
>
>
>- Davide
>
>
>
>  
>
Sorry Davide,

I forgot to mention that a UP 2.6-test9 works fine whilst an SMP version 
doesn't (unless I use "noapic")

2.4 in dual or UP seems rock-solid (bar one issue which may have been 
network card related).

Dan.




