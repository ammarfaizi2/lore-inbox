Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264531AbRFYNpT>; Mon, 25 Jun 2001 09:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264541AbRFYNpJ>; Mon, 25 Jun 2001 09:45:09 -0400
Received: from jalon.able.es ([212.97.163.2]:10407 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264531AbRFYNo7>;
	Mon, 25 Jun 2001 09:44:59 -0400
Date: Mon, 25 Jun 2001 15:48:37 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: landley@webofficenow.com
Cc: "J . A . Magallon" <jamagallon@able.es>, landley@webofficenow.com,
        "J . A . Magallon" <jamagallon@able.es>, landley@webofficenow.com,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010625154837.A8068@werewolf.able.es>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz> <01062412555901.03436@localhost.localdomain> <20010625003002.A1767@werewolf.able.es> <01062414211303.03436@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <01062414211303.03436@localhost.localdomain>; from landley@webofficenow.com on Sun, Jun 24, 2001 at 20:21:12 +0200
X-Mailer: Balsa 1.1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This discussion seems to go nowhere. Thanks for your comments. I know much
more on Linux than before.

I am happy that processes in Linux are so marvelous. Linux does not need
a decent POSIX threads implementation because the same functionality can
be achived with processes. Do what you like, you write the kernel code.
I could write my soft using fork special fetaures in Linux.
But I want it to be portable. If threads in linux are so bad, it is bad
luck for me. I will go slow. It its the only portable way todo afordable
shared memory threading without filling your program of shm-xxxx.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac17 #2 SMP Fri Jun 22 01:36:07 CEST 2001 i686
