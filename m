Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318304AbSIBOUn>; Mon, 2 Sep 2002 10:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318308AbSIBOUn>; Mon, 2 Sep 2002 10:20:43 -0400
Received: from jalon.able.es ([212.97.163.2]:30205 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318304AbSIBOUm>;
	Mon, 2 Sep 2002 10:20:42 -0400
Date: Mon, 2 Sep 2002 16:24:55 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: andre@linuxdiskcert.org
Subject: IDE patches status
Message-ID: <20020902142455.GC6543@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have seen the new IDE patch at http://www.linuxdiskcert.org/:

http://www.linuxdiskcert.org/ide-2.4.20-pre4-ac2.1.patch.bz2

It is done against -pre4-ac4 (highmem IO was introduced in -pre2, so I
suppose it is highio-aware).

Ist not there any version for plain 2.4.19 ? Does it depend on any
specific bits from -ac ? If yes, would this bit easily extracted ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre5 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
