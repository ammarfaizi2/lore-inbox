Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTDWDeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 23:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTDWDeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 23:34:44 -0400
Received: from [203.199.93.15] ([203.199.93.15]:39181 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id S263944AbTDWDem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 23:34:42 -0400
From: "ramands" <ramands@indiatimes.com>
Message-Id: <200304230308.IAA12636@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>, <linux-newbie@vger.kernel.org>
CC: <whitnl73@juno.com>, <ray@comarre.com>, <sneakums@zork.net>,
       <marcus@infa.abo.fi>, <martin.zwickel@technotrend.de>
Reply-To: "ramands" <ramands@indiatimes.com>
Subject: oops in kmalloc
Date: Wed, 23 Apr 2003 09:11:39 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
i am getting OOPS in Kmalloc .

void **data;
qset = 1000;

dptr->data = kmalloc(qset * sizeof(char *), GFP_KERNEL);

what could the possible the cause of the error 

Raman


Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy The Best In BOOKS at http://www.bestsellers.indiatimes.com

Bid for for Air Tickets @ Re.1 on Air Sahara Flights. Just log on to http://airsahara.indiatimes.com and Bid Now !

