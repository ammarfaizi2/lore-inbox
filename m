Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293073AbSBWBeC>; Fri, 22 Feb 2002 20:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293067AbSBWBdz>; Fri, 22 Feb 2002 20:33:55 -0500
Received: from jalon.able.es ([212.97.163.2]:53666 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S293070AbSBWBdk>;
	Fri, 22 Feb 2002 20:33:40 -0500
Date: Sat, 23 Feb 2002 02:33:32 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>, rwhron@earthlink.net
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
Message-ID: <20020223023332.A1689@werewolf.able.es>
In-Reply-To: <20020222015003.A1641@werewolf.able.es> <20020222073841.EC00F89C87@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020222073841.EC00F89C87@cx518206-b.irvn1.occa.home.com>; from barryn@pobox.com on vie, feb 22, 2002 at 08:38:41 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020222 Barry K. Nathan wrote:
>> Extras:
>[snip]
>> - irqrate-A1, intr-seq-file
>
>FWIW, the irqrate-A1 patch from the -slb/-jam series kernels
>(2.4.18-rc1-slb2 through 2.4.18-rc2-jam1 for certain) seems to make one of
>my computers (a dual 1GHz PIII, Iwill DVD266-R motherboard) hang when I
>access the floppy drive. I don't believe this happens on other
>(uniprocessor, not SMP) machines I have here, although I'm not certain
>about that. This is 100% reproducible.
>
>This bug report is probably rather vague, but I probably won't have time
>for anything more detailed or any debugging activities related to this for
>several weeks, and I hope this report is better than nothing.
>

My box also hangs acessing the floppy. Strange thing is that it also
hangs without irqrate-A1. Will send an oops.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc4-jam1 #1 SMP Sat Feb 23 01:39:06 CET 2002 i686
