Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281020AbRKTKzo>; Tue, 20 Nov 2001 05:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281021AbRKTKzf>; Tue, 20 Nov 2001 05:55:35 -0500
Received: from relay-2m.club-internet.fr ([195.36.216.171]:33231 "HELO
	relay-2m.club-internet.fr") by vger.kernel.org with SMTP
	id <S281020AbRKTKzV>; Tue, 20 Nov 2001 05:55:21 -0500
Message-ID: <3BFA3699.6050601@freesurf.fr>
Date: Tue, 20 Nov 2001 11:55:21 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011116
X-Accept-Language: fr, en, fr-fr
MIME-Version: 1.0
To: Duncan Sands <duncan.sands@math.u-psud.fr>, linux-kernel@vger.kernel.org
Subject: Re: [bug report] System hang up with Speedtouch USB hotplug
In-Reply-To: <E165lQB-0001DZ-00@baldrick>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:

> Did you try without the preempt patch?


As I said before, I wasn't able to reproduce the hang, even with the 
preempt patch, so I don't know.


> 
> Duncan.
> 
> PS: You say "I'm not using binary driver from Alcatel but the free user-mode 
> implementation...".  In fact the Alcatel kernel module is open source (GPL)!


I didn't looked close at the Alcatel driver... so, maybe the kernel 
module is gpl.


> Here's the situation as I understand it:

[...]
Yes, it's how I understand it too


-- 
  ** Gael Le Mignot, Ing3 EPITA, Coder of The Kilobug Team **
Home Mail : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM       : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Web       : http://kilobug.freesurf.fr or http://drizzt.dyndns.org

"Software is like sex it's better when it's free.", Linus Torvalds

