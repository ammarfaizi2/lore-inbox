Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136708AbRECKmX>; Thu, 3 May 2001 06:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136730AbRECKmN>; Thu, 3 May 2001 06:42:13 -0400
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:33937 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136708AbRECKl5>; Thu, 3 May 2001 06:41:57 -0400
Message-ID: <3AF135F0.6ED58AB3@home.com>
Date: Thu, 03 May 2001 03:41:52 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
CC: Moses McKnight <m_mcknight@surfbest.net>, linux-kernel@vger.kernel.org
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <Pine.LNX.4.10.10105012333400.18414-100000@coffee.psychology.mcmaster.ca> <l0313030eb715db09b49f@[192.168.239.105]>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:

> 
> I'm using an Abit KT7 board (KT133) and my new 1GHz T'bird (running 50-60°C
> in a warm room) is giving me no trouble.  This is with the board and RAM
> pushed as fast as it will go without actually overclocking anything...  and
> yes, I do have Athlon/K7 optimisations turned on in my kernel (2.4.3).
> 

  I wonder if the KT133A (which is what the IWILL KK266 is based on)
differences
a could be a source of the problem.  My FSB is at plain old 100 MHz
since I
have regular PC100 SDRAM.  Overclocked, or not, I get the same results. 
I,
too, had an ABIT KA7[-RAID] and it was rock solid.  So much for "if it's
not broke, don't fix it" -- I should have listened to my gf, but that's
the life of an upgrader ;)...  In general the IWILL got great reviews at
a
number of reliable hardware review sites, and hey, it doesn't lock up in
windows ;) (ok don't flame me for that ;)).

 --Seth
