Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSIBOLa>; Mon, 2 Sep 2002 10:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318308AbSIBOL3>; Mon, 2 Sep 2002 10:11:29 -0400
Received: from jalon.able.es ([212.97.163.2]:61436 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318305AbSIBOL2>;
	Mon, 2 Sep 2002 10:11:28 -0400
Date: Mon, 2 Sep 2002 16:15:43 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: -aa VM status wrt standard kernel
Message-ID: <20020902141543.GA6543@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Back from summer holidays, and trying to catch the train again...

I gave up in 2.4.20-pre1. I have built now -pre5, and saw that some things
from -aa tree (or newer versions) went into mainline:

(from patch-2.4.20.log)
pre1 -> pre2:
 <hch@lst.de>:
  o small VM updates from -aa (1/5)
  o small VM updates from -aa (2/5)
  o small VM updates from -aa (4/5)
  o small VM updates from -aa (5/5)
  o minor VM changes from -aa (2/3)
  o minor VM changes from -aa (3/3)
  o Re: [PATCH] small VM updates from -aa (3/5)

 Jens Axboe <axboe@suse.de>:
  o Add block IO directly from highmem support
pre4 ->pre5:
Scott Feldman <scott.feldman@intel.com>:
  o e100 net driver update 1/3...
  o e1000 net driver update 1/5...

small bits for SMP, like alignments and so on.

I have tried to dig into MARC archives but found no message. Anyone has
a pointer to read what went in ?

BTW: Andrea, is there any -aa cooking ? I am trying to merge the rest of the
latest I had...

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre5 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
