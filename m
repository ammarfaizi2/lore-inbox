Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUGNN0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUGNN0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 09:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUGNN0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 09:26:07 -0400
Received: from [203.197.150.194] ([203.197.150.194]:36061 "EHLO
	Bhadra.amrita.ac.in") by vger.kernel.org with ESMTP id S267381AbUGNN0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 09:26:05 -0400
Message-ID: <60580.203.197.150.195.1089808265.squirrel@203.197.150.195>
Date: Wed, 14 Jul 2004 18:01:05 +0530 (IST)
Subject: Real-Time thread scheduling in linux??
From: "Harish K Harshan" <harish@amritapuri.amrita.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

     I would like to know if there is any way to give a thread real-time
priority under Linux, and also if it is possible using the pthread
library. How would the kernel handle such threads? And do we need to
implement locking systems, so that this thread does not block other
threads permanently? Please help me, because I am working on a data
acquisition application, and the acquisition thread needs almost
real-time priority, and loss of data is not affordable.

Thanks in advance,
Harish K Harshan.


***********************************************************************************************
 Amrita Institutions, Amritapuri, Kerala, India - 
 Sent using Amrita Mail  
 Visit http://www.amrita.edu 
