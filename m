Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261991AbREPQUP>; Wed, 16 May 2001 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261993AbREPQUE>; Wed, 16 May 2001 12:20:04 -0400
Received: from www.topmail.de ([212.255.16.226]:50161 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S261991AbREPQTw>;
	Wed, 16 May 2001 12:19:52 -0400
From: mirabilos <eccesys@topmail.de>
To: <andrea@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: rwsem, gcc3 again
Message-Id: <20010516161540.A3A7AA5A710@www.topmail.de>
Date: Wed, 16 May 2001 18:15:40 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,
I doubt that it applies against -ac and I have only very few hard disk space,
so please don't beat me I could not try... (I tried the second-to-last but
it didn't apply either)
But 2.4.3-ac7 works very fine with your older patch.
As noticed, I now solved by CONFIG_RWSEM_GENERIC_SPINLOCK=y (as in i386)
by hand on i686.

Sorry
-mirabilos
-- 
by telnet
