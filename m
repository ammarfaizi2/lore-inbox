Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbRE3Vc3>; Wed, 30 May 2001 17:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbRE3VcJ>; Wed, 30 May 2001 17:32:09 -0400
Received: from jalon.able.es ([212.97.163.2]:31743 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262632AbRE3VbH>;
	Wed, 30 May 2001 17:31:07 -0400
Date: Wed, 30 May 2001 23:30:55 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: here comes the summer...
Message-ID: <20010530233055.A1138@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...again (I think I asked just the same last summer)
and lm_sensors is still out of the kernel (we have got 40ºC in Spain
this week, and I would like to know how my PIIs suffer...)

Anybody knows if sensors will get into kernel anytime in this century ?
Yes, it can generate patches automagically, but there is a big big lack
of sync with latest kernels. Patches generated are silly big because of
things like
#endif /* Whatever you like */
vs
#endif XXXXX
and init functions and so on...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac4 #1 SMP Wed May 30 00:17:45 CEST 2001 i686
