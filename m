Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281743AbRKQM7R>; Sat, 17 Nov 2001 07:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281744AbRKQM7H>; Sat, 17 Nov 2001 07:59:07 -0500
Received: from relay-1v.club-internet.fr ([194.158.96.112]:4233 "HELO
	relay-1v.club-internet.fr") by vger.kernel.org with SMTP
	id <S281743AbRKQM7C>; Sat, 17 Nov 2001 07:59:02 -0500
Message-ID: <3BF65F09.30309@freesurf.fr>
Date: Sat, 17 Nov 2001 13:58:49 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011116
X-Accept-Language: fr, en, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, speedtouch@ml.free.fr
Subject: Re: [bug report] System hang up with Speedtouch USB hotplug
In-Reply-To: <3BF5C3AF.8090107@freesurf.fr> <20011116231335.A18746@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Sat, Nov 17, 2001 at 02:55:59AM +0100, Kilobug wrote:
> 
>>[4.] Kernel version (from /proc/version):
>>2.4.12-ac5 with preempt patch (and some patches from Netfilter's 
>>patch-o-matic)
>>
> 
> Does the problem happen on a kernel without the preemt patch?


I don't know. I have tried a couple of times to reproduce this bug with 
my kernel (with preempt patch), but I wasn't to have the system hangs 
again. So I can't tell you if this problem could happen without the 
preempt patch... Sorry.

-- 
  ** Gael Le Mignot, Ing3 EPITA, Coder of The Kilobug Team **
Home Mail : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM       : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Web       : http://kilobug.freesurf.fr or http://drizzt.dyndns.org

"Software is like sex it's better when it's free.", Linus Torvalds

