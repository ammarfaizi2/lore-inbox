Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbRE1RBY>; Mon, 28 May 2001 13:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263102AbRE1RBO>; Mon, 28 May 2001 13:01:14 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:21742 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S263100AbRE1RBJ>;
	Mon, 28 May 2001 13:01:09 -0400
Message-ID: <3B128437.7C166E53@pcsystems.de>
Date: Mon, 28 May 2001 19:00:39 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: unresolved symbols printk ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am having problems with loading modules:
I always get the unresolved symbols message.
I didn't find any documentation for that, can you help me ?

What I did:

compiled 2.4.4; installed modules.
depmod -ae -F /usr/src/linux/System.map 2.4.4 runs fine,
depmod -a doesn't run fine (unresolved symbols)

modprobe any_module results in unresolved modules message.

modutils are 2.4.2.

Any ideas what I did wrong ?

Sincerly,

Nico

