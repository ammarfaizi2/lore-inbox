Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVLGK2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVLGK2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVLGK1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:27:52 -0500
Received: from mail.di.fct.unl.pt ([193.136.122.1]:61867 "EHLO
	ns.di.fct.unl.pt") by vger.kernel.org with ESMTP id S1750797AbVLGK1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:27:49 -0500
From: Marco Correia <mvc@di.fct.unl.pt>
To: linux-kernel@vger.kernel.org
Subject: slow boot
Date: Wed, 7 Dec 2005 10:27:26 +0000
User-Agent: KMail/1.9
Organization: DI - FCT/UNL
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512071027.26364.mvc@di.fct.unl.pt>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been experiencing very VERY slow boots after I've upgraded from kernel 
2.6.10 to 2.6.14.2. The boot process is fast until the start of the init 
script, after this 2.6.14.2 spends 10 seconds or so for each init task.

I was searching for answers to my problem and found this thread 
http://www.ussg.iu.edu/hypermail/linux/kernel/0508.3/1741.html but I really 
have no clue what they are talking about.

uname -a:
Linux ravel 2.6.10 #13 SMP Thu Jul 14 00:24:03 WEST 2005 i686 Intel(R) 
Pentium(R) 4 CPU 3.40GHz GenuineIntel GNU/Linux

Please excuse if there is a better place to ask this than here. I'm not 
subscribed so please answer me directly.

thanks
Marco

-- 
Marco Correia <mvc@di.fct.unl.pt>
