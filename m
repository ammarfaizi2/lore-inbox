Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314049AbSDQNkp>; Wed, 17 Apr 2002 09:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSDQNkp>; Wed, 17 Apr 2002 09:40:45 -0400
Received: from jalon.able.es ([212.97.163.2]:53638 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314049AbSDQNko>;
	Wed, 17 Apr 2002 09:40:44 -0400
Date: Wed, 17 Apr 2002 15:40:04 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
Message-ID: <20020417134004.GA2025@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.10.10204161720260.10691-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.17 Andre Hedrick wrote:
>There is a micro bug in 3a, look for 4 to arrive.
>
>regards
>
[...]
>> 
>> - ide update -3a (very shrinked wrt original, the big ppc part has gone
>>   in mainline)

Can it be related to my system getting hung on boot trying to do
an hdparm ?
I had not the time to dig more, just disabled it and booted fine (I had
some work to get done...)

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam1 #1 SMP Wed Apr 17 00:42:27 CEST 2002 i686
