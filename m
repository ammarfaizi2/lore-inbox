Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSFTQmw>; Thu, 20 Jun 2002 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSFTQmP>; Thu, 20 Jun 2002 12:42:15 -0400
Received: from jalon.able.es ([212.97.163.2]:14748 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315282AbSFTQlt>;
	Thu, 20 Jun 2002 12:41:49 -0400
Date: Thu, 20 Jun 2002 18:41:43 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5-dj: configurable NR_CPUS
Message-ID: <20020620164143.GC9813@werewolf.able.es>
References: <1024533919.921.46.camel@sinai> <20020620160058.GA9813@werewolf.able.es> <1024591065.921.132.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1024591065.921.132.camel@sinai>; from rml@tech9.net on Thu, Jun 20, 2002 at 18:37:45 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.20 Robert Love wrote:
>On Thu, 2002-06-20 at 09:00, J.A. Magallon wrote:
>
>> On 2002.06.20 Robert Love wrote:
>>
>> >Attached patch is a lovely rendition of the CONFIG_NR_CPUS patch Andrew
>> >and I have been tossing around.
>> >
>> 
>> Default for alpha is missing ?
>
>No... the default in 64 in config.in.  Do you mean there is no defconfig
>entry?  Well that is because CONFIG_SMP is not set and CONFIG_NR_CPUS is
>dependent on it.
>

Ok.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)
