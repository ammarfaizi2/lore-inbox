Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130895AbRCJCse>; Fri, 9 Mar 2001 21:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130902AbRCJCsY>; Fri, 9 Mar 2001 21:48:24 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:16390 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S130895AbRCJCsH>;
	Fri, 9 Mar 2001 21:48:07 -0500
Message-ID: <3AA99581.48A1CC16@yahoo.co.uk>
Date: Fri, 09 Mar 2001 21:46:25 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug seems to be fixed in 2.4.2-ac16.

Thanks again to Arnaldo Carvalho de Melo.

Thomas

On 21 Feb 2001 I wrote:
> Update on the "unregister_netdevice" bug ... 
> 
> Arnaldo Carvalho de Melo found one bug but there 
> remains another one that makes the dev->refcnt too 
> high instead of too low. 
> 
> To be continued ... 
> 
> Thomas
