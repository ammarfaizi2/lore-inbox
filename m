Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273507AbRIQHo2>; Mon, 17 Sep 2001 03:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273514AbRIQHoT>; Mon, 17 Sep 2001 03:44:19 -0400
Received: from jalon.able.es ([212.97.163.2]:12931 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S273507AbRIQHoF>;
	Mon, 17 Sep 2001 03:44:05 -0400
Date: Mon, 17 Sep 2001 09:44:21 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: Linux 2.4.9-ac11
Message-ID: <20010917094421.A4490@werewolf.able.es>
In-Reply-To: <200109170049.f8H0nkEa008317@sleipnir.valparaiso.cl> <m366ail5pp.fsf@giants.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m366ail5pp.fsf@giants.mandrakesoft.com>; from chmouel@mandrakesoft.com on Mon, Sep 17, 2001 at 07:57:38 +0200
X-Mailer: Balsa 1.2.pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010917 Chmouel Boudjnah wrote:
>Horst von Brand <vonbrand@sleipnir.valparaiso.cl> writes:
>
>> Boots and panics immediately "trying to kill init"
>
>Backout the changes to fs/locks.c or the patch of Trond :
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=100019824200351&w=2
>
>> 
>> i686, stock config with many modules. Config has worked here for ages.
>

Here booted and works fine, built with gcc-3.0.1:
werewolf:~# cat /proc/version
Linux version 2.4.9-ac11 (root@werewolf.able.es) (gcc version 3.0.1) #1 SMP Mon Sep 17 00:00:56 CEST 2001

Should I also had a panic ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.9-ac11 #1 SMP Mon Sep 17 00:00:56 CEST 2001 i686
