Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311024AbSCXSfl>; Sun, 24 Mar 2002 13:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310825AbSCXSfc>; Sun, 24 Mar 2002 13:35:32 -0500
Received: from mout1.freenet.de ([194.97.50.132]:17129 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S310435AbSCXSfU>;
	Sun, 24 Mar 2002 13:35:20 -0500
Message-ID: <3C9E1BD1.6040405@freenet.de>
Date: Sun, 24 Mar 2002 19:32:49 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020323
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <E16pCdY-0006tY-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>At the point you hit OOM every possible heuristic is simply handwaving that
>>>will work for a subset of the user base. Fix the real problem and it goes
>>>away.
>>
>>On the other hand - nobody is perfect and there can be such situations. 
> 
> 
> My system cannot (short of a bug) go OOM. Thats what the new overcommit
> mode 2/3 ensures

How does a process react that doesn't get no more memory?


Regards,
Andreas Hartmann

