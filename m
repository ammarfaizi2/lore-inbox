Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbSIWNWU>; Mon, 23 Sep 2002 09:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbSIWNWU>; Mon, 23 Sep 2002 09:22:20 -0400
Received: from mta.sara.nl ([145.100.16.144]:46984 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S261348AbSIWNWT>;
	Mon, 23 Sep 2002 09:22:19 -0400
Date: Mon, 23 Sep 2002 15:27:28 +0200
Subject: Re: 2.5.38 on ppc/prep
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: <linux-kernel@vger.kernel.org>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <20020923014122.17320@192.168.4.1>
Message-Id: <348D72FE-CEF8-11D6-A08A-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On maandag, september 23, 2002, at 03:41 , Benjamin Herrenschmidt wrote:

>> very well possible. If Linus keeps up the pace on kernel releases I'll
>> just d/l 2.5.39 tomorrow and try again ;)
>
> Well, I don't know if a fix went in yet, Paulus did a quick hack but
> didn't submit a real patch as we are waiting from someone knowing
> sys_mprotect() better to show up
>
> Ben.
>
>

I saw Paulus' post a few days ago. I'm fully aware that 2.5 is not ready 
for anything serious yet on ppc, I just became curious to know if I 
could get it to compile and run. I'll just keep on trying and posting 
small patches that I need to compile things. I don't have the time to do 
any real hacking, but a small patch now and then is doable ;-)

--
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


