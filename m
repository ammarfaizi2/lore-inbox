Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRBVLnq>; Thu, 22 Feb 2001 06:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRBVLnh>; Thu, 22 Feb 2001 06:43:37 -0500
Received: from jalon.able.es ([212.97.163.2]:29632 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129146AbRBVLnc>;
	Thu, 22 Feb 2001 06:43:32 -0500
Date: Thu, 22 Feb 2001 12:43:24 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.2
Message-ID: <20010222124324.A1026@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.10.10102211811430.1005-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.10.10102211811430.1005-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Feb 22, 2001 at 03:19:43 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building with gcc-2.96:

In file included from /usr/src/linux/include/linux/raid/md.h:50,
                 from init/main.c:24:
/usr/src/linux/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux/include/linux/raid/md_k.h:41: warning: control reaches end of non
-void function

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2 #1 SMP Thu Feb 22 11:40:37 CET 2001 i686

