Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTH1USI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTH1USI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:18:08 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:53489 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264241AbTH1USG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:18:06 -0400
Message-Id: <200308282017.h7SKHxl5002088@ginger.cmf.nrl.navy.mil>
To: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
       solarz@wsisiz.edu.pl
Subject: Re: [lukasz@wsisiz.edu.pl: Re: [Linux-ATM-General] Re: linux-2.4.22 Oops on ATM PCA-200EPC] 
In-Reply-To: Message from Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl> 
   of "Thu, 28 Aug 2003 18:34:45 +0200." <20030828163445.GA32095@oceanic.wsisiz.edu.pl> 
Date: Thu, 28 Aug 2003 16:17:59 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have appled this patch, atm interfaces was created without any Ooops. 
>Unfortunately, atm interfaces exists (with ip address), i can ping them 
>localy but no any traffic goes through them. I can't ping remote atm 
>inteface. ATM card is Fore LE155 (nicstar). 2.4.21-rc6 works well.

can you describe your configuration a little more?  i use clip with
an arp server.  i was able to join and contact hosts on our local
clip network.
