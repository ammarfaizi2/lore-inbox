Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262199AbTDAJGi>; Tue, 1 Apr 2003 04:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262205AbTDAJGi>; Tue, 1 Apr 2003 04:06:38 -0500
Received: from [203.199.93.15] ([203.199.93.15]:38411 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S262199AbTDAJGh>; Tue, 1 Apr 2003 04:06:37 -0500
From: "ramands" <ramands@indiatimes.com>
Message-Id: <200304010845.OAA14558@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: "ramands" <ramands@indiatimes.com>
Subject: Error:variable has intializer but incomplete type
Date: Tue, 01 Apr 2003 14:48:31 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am trying to learn and write device driver on linux kernel 2.4 redhat distribution 

iam getting compilation errors for driver code.
struct file_operations my_ops ={NULL,my_read,my_write,NULL,NULL,NULL
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL };

ERROR -> my_ops has intializer but incomplete type

Can anyone help me with this 
Regards
Raman



Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy The Best In BOOKS at http://www.bestsellers.indiatimes.com

Bid for for Air Tickets @ Re.1 on Air Sahara Flights. Just log on to http://airsahara.indiatimes.com and Bid Now !

