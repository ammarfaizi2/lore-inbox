Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSGSPWy>; Fri, 19 Jul 2002 11:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSGSPWy>; Fri, 19 Jul 2002 11:22:54 -0400
Received: from jalon.able.es ([212.97.163.2]:59379 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316663AbSGSPWx>;
	Fri, 19 Jul 2002 11:22:53 -0400
Date: Fri, 19 Jul 2002 17:25:33 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>, rwhron@earthlink.net
Subject: [PATCHSET] Linux 2.4.19-rc2-jam1 [Was: Re: [PATCHSET] Linux 2.4.19-rc1-jam1]
Message-ID: <20020719152533.GA1835@werewolf.able.es>
References: <Pine.LNX.4.44.0207182040560.3525-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0207182040560.3525-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Fri, Jul 19, 2002 at 04:41:19 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.19 Thunder from the hill wrote:
>Hi,
>
>On Fri, 19 Jul 2002, J.A. Magallon wrote:
>> The idea is to easy the way for Randy Hron to compare:
>> - rc2
>> - rc2-aa1
>> - rc2-jam1 minus irqrate == rc2-aa1 plus smptimers (that I think will not
>>   make a big difference)
>> - rc2-jam1 full == rc2-aa1 + smptimers + irqrate (if you don't rmmod anything...)
>
>So the heading is inaccurate.
>

Oops, yes. It is against rc2.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc2-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.8mdk)
