Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285006AbRLRURd>; Tue, 18 Dec 2001 15:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284958AbRLRURS>; Tue, 18 Dec 2001 15:17:18 -0500
Received: from mout0.freenet.de ([194.97.50.131]:34183 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S284967AbRLRUQ4>;
	Tue, 18 Dec 2001 15:16:56 -0500
Message-ID: <3C1F96FC.8050803@athlon.maya.org>
Date: Tue, 18 Dec 2001 20:20:28 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Wim Coekaerts <wim.coekaerts@oracle.com>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17rc1] fatal problem: system time suddenly changes
In-Reply-To: <3C1F8825.2080802@athlon.maya.org> <20011218104500.F22677@nic1-pc.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wim,


Wim Coekaerts wrote:

> On Tue, Dec 18, 2001 at 07:17:09PM +0100, Andreas Hartmann wrote:
> 
>>Hello all,
>>
>>I'm running kernel 2.4.17rc1 and I detected suddenly changes of
>>systemtime. I saw it in KDE and tested it afterwards in a konsole. I
>>repeated as fast as possible the date program as following:
>>
>>This problem appears not directly after reboot but some time after
>>reboot. The time when it appears after reboot is different. I can't say
>>it's after 3 hours or 10 hours. It suddenly appears and doesn't
>>disappear. I have to reboot the system to get rid of the problem.
>>
> 
> Does it start shortly after or during heavy disk io ?
> 
> I have had this with a via chipset board as well, always occured with lots of disk io.
> 

Yes, it's a VIA board. I thought, it could be depending on disk io. But 
I have the problem without havy disk io, too.
Another thing I suspect is the memory usage: If the memory (only RAM) is 
used at about one hundred percent, it seems to be more likely.
On the other hand, I can force the problem by doing some restarts of X 
directly after rebooting (about ten or twenty times). The memory usage 
is at this moment very low.


Regards,
Andreas

