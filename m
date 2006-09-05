Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWIEVYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWIEVYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWIEVYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:24:20 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:31930 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751375AbWIEVYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:24:19 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
Date: Wed, 06 Sep 2006 07:24:09 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <lcqrf2hjo1fo28jpikf4iebq55c955folf@4ax.com>
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com> <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr> <44FD7B1E.7020102@aitel.hist.no> <1157467176.9018.48.camel@localhost.localdomain> <b9arf2lrbh5v4pv9klbtujfhvq3hiuehdk@4ax.com> <m3veo2b3ht.fsf@defiant.localdomain>
In-Reply-To: <m3veo2b3ht.fsf@defiant.localdomain>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2006 19:57:34 +0200, Krzysztof Halasa <khc@pm.waw.pl> wrote:

>Grant Coady <gcoady.lk@gmail.com> writes:
>
>> Which leads back to this slackware user, who's never used an initrd, 
>> thinking about dual root partitions just to get the name change from 
>> another /etc/fstab?  
>
>I think it's unnecessary, /etc/fstab is not used while mounting root fs,
>and both mount and fsck should understand labels (i.e., you can put
>labels there, even for root fs).

Thanks, Krzysztof, Alan and others, I can do labels now, avoiding 
them too long ;)

Grant.
