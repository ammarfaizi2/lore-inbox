Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276505AbRJYWBW>; Thu, 25 Oct 2001 18:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276470AbRJYWBJ>; Thu, 25 Oct 2001 18:01:09 -0400
Received: from jalon.able.es ([212.97.163.2]:38031 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276477AbRJYWBB>;
	Thu, 25 Oct 2001 18:01:01 -0400
Date: Fri, 26 Oct 2001 00:00:31 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lost Logic <lostlogic@toughguy.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel compiler
Message-ID: <20011026000031.A2245@werewolf.able.es>
In-Reply-To: <3BD841B7.5060405@toughguy.net> <E15wo76-0005TI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15wo76-0005TI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 25, 2001 at 19:16:15 +0200
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011025 Alan Cox wrote:
>> GCC 3.0 Produces slower code, eh?  I was of the understanding that it 
>> contained many more optimizations than previous versions...???
>
>It does - but the end result right now is typically slower. it has the
>infrastructure and optimisation code to create faster code than 2.x ever
>could but it isnt yet at the point it has been refined to do so
>-

3.0.2 is out. Time to check it.

What I sure have seen is that code is much bigger than with 2.96. About 40k
for an 800k kernel.
Wil try with 14-pre1.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-pre1-beo #1 SMP Thu Oct 25 16:19:19 CEST 2001 i686
