Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbRAVOqd>; Mon, 22 Jan 2001 09:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbRAVOqX>; Mon, 22 Jan 2001 09:46:23 -0500
Received: from www.zincro.com ([209.88.62.109]:33288 "EHLO mail.zincro.com")
	by vger.kernel.org with ESMTP id <S131240AbRAVOqU>;
	Mon, 22 Jan 2001 09:46:20 -0500
Date: Mon, 22 Jan 2001 09:48:49 -0500 (COT)
From: Plinio Barraza <plinio@zincro.com>
To: linux-kernel@vger.kernel.org
Subject: Replicating Current Kernell
In-Reply-To: <003701c08481$2461a300$27f8423e@avenger>
Message-ID: <Pine.LNX.4.10.10101220939340.3246-100000@mail.zincro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear list,

I am new to the list so please forgive me if I am repeating a recent
thread.

I have a kernel that is the result of a Red Hat distribution and works
great.  Only, I have to recompile the kernel in order to have policy
routing capabilities.  As I am very inexperienced, I would like to
replicate my system as close as posible with only  this added issue.  I
tried recompiling the same kernel and had a little trouble (mainly <Unable
to mount root fs on 08:0a>).  I figure it had something to do with the RAM
Disk that boots the system now not being in tune with the new kernel I
compiled.  As I am working with the same source (2.2.12) I guessed I sould
be able to use the same initrd file.

My question is:  Is there a way to explore the current kernel
configuration, or is there a way to enable a feature into the kernel (such
as advanced routing) without recompiling?

Any pointers or help is much apreciated

Thanks in advance

Plinio

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
