Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbTCGNWE>; Fri, 7 Mar 2003 08:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbTCGNWE>; Fri, 7 Mar 2003 08:22:04 -0500
Received: from [202.125.87.14] ([202.125.87.14]:42157 "EHLO brahma.roc.com")
	by vger.kernel.org with ESMTP id <S261574AbTCGNWE>;
	Fri, 7 Mar 2003 08:22:04 -0500
Message-Id: <5.1.1.6.0.20030307190133.009fdd00@mail.roc.co.in>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 07 Mar 2003 19:02:20 +0530
To: linux-kernel@vger.kernel.org
From: milind <milind@roc.co.in>
Subject: Exporting symbols from ip_output.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!!
	Can anybody tell me how can I export symbols from ip_output.c 
EXPORT_SYMBOL() does'nt seem to work. I also added ip_output.o to the 
export-objs list in Makefile
thanx
Milind 

