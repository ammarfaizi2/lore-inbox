Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131984AbRCZJsW>; Mon, 26 Mar 2001 04:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132386AbRCZJsC>; Mon, 26 Mar 2001 04:48:02 -0500
Received: from jalon.able.es ([212.97.163.2]:25760 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131984AbRCZJsB>;
	Mon, 26 Mar 2001 04:48:01 -0500
Date: Mon, 26 Mar 2001 11:47:13 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: ac25 - hang mounting swap
Message-ID: <20010326114713.A1150@werewolf.able.es>
In-Reply-To: <E14hQaE-0001AK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14hQaE-0001AK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 26, 2001 at 08:34:26 +0200
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.26 Alan Cox wrote:
> 
> 2.4.2-ac25

It just hangs when init scripts try to activate swap. I will look at
what is init trying to mount and decode the info that Sysrq-P gives,
but if this suggests somebody anything already known...
Sysrq-p gives different info as time goes, so perhaps it is not stuck
but caught in an infinite loop trying to mount the only swap partition
I have.

All previous av worked fine.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac24 #1 SMP Sat Mar 24 12:40:29 CET 2001 i686

