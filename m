Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTDXELC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTDXELC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:11:02 -0400
Received: from [203.199.93.15] ([203.199.93.15]:48645 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id S264375AbTDXELB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:11:01 -0400
From: "ramands" <ramands@indiatimes.com>
Message-Id: <200304240344.JAA29170@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>, <linux-newbie@vger.kernel.org>
CC: <whitnl73@juno.com>, <ray@comarre.com>, <sneakums@zork.net>
Reply-To: "ramands" <ramands@indiatimes.com>
Subject: OOPS in Kmalloc
Date: Thu, 24 Apr 2003 09:46:17 +0530
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

