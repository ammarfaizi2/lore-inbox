Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTBCMyq>; Mon, 3 Feb 2003 07:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTBCMyq>; Mon, 3 Feb 2003 07:54:46 -0500
Received: from meel.hobby.nl ([212.72.224.15]:37380 "EHLO meel.hobby.nl")
	by vger.kernel.org with ESMTP id <S266285AbTBCMyp>;
	Mon, 3 Feb 2003 07:54:45 -0500
Message-ID: <3E3EBF86.6050000@kader.hobby.nl>
Date: Mon, 03 Feb 2003 14:14:14 -0500
From: "l.scheelings" <l.scheelings@kader.hobby.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Code: Bad EIP value
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, i have a little shutdown problem. I tried to find the answer 
on the internet,
irc channels and so on , but no one there knows. Someone in the mandrake 
irc channel at freenode.net advised me to turn to you.

I use mandrake dolphin 9.0 download version,
on an AMD k6 400 3d now, with dfi motherboard, and ami bios.
when i shutdown after the message

powerdown
 
i get an error:

EIP: 0050:[<00008865>] Not tainted
EFLAGS: 00010046
eax: 0005301 ebx: 00000001 ecx: 00000000 edx: 00000000
esi: 00008136 edi: 00000296 ebp: 67890000 esp: c8ae7dd0
ds:  0058 es: 000 ss: 0018
Process halt cpid: 2559, stackpage+ c8ae70000
stack: 02968df  81360000 00000000
          0000000 00000000  81250058
          c01148dd 00000010

call Trace : [<c01148dd>] [<c0110000>]

Code: Bad EIP value


        Is there any direction where is should look for this error?
and how can i get around it?
I tried the <linux noapic> at boot but that did not solve this error.
When i turn off the power after this error and then power up the pc and 
boot agian
everythings works as normal. < but wen shutting down the error is there 
agian.>

Hopefully you can give me some information , so that i can solve this 
litttle problem.

With lots of greeting from the netherlands,

l.scheelings@kader.hobby.nl

Powered by GNU/linux






