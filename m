Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVCaGUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVCaGUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCaGUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:20:14 -0500
Received: from 203.199.60.6.static.vsnl.net.in ([203.199.60.6]:28165 "EHLO
	Mailout.ltindia.com") by vger.kernel.org with ESMTP id S262480AbVCaGTw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:19:52 -0500
Message-Id: <s24be47e.095@EMAIL>
X-Mailer: Novell GroupWise Internet Agent 6.0.3
Date: Thu, 31 Mar 2005 11:52:04 +0530
From: "Banu R Reefath" <reefathbanur@myw.ltindia.com>
To: <linux-kernel@vger.kernel.org>
Subject: Timers to threads
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Mailout/ltindia(Release 6.5|September 26, 2003) at
 03/31/2005 11:49:20 AM,
	Serialize by Router on Mailout/ltindia(Release 6.5|September 26, 2003) at
 03/31/2005 11:49:29 AM,
	Serialize complete at 03/31/2005 11:49:30 AM,
	Serialize by Router on Mailout/ltindia(Release 6.5|September 26, 2003) at
 03/31/2005 11:49:30 AM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Dear Sir/Mam
  We are using Linux in one of our embedded products.This is the first time we are  working in this Platform.We have few doubts regarding implementing s/w timers & how  to pass the  timer interrupts to threads .
 In net we coudnt find exactly what we want .Could you please help us in this regard?

Ideas from us
1. If we want a thread to execute at particular intervals should it be done only through 
usleep()  system call ? Will it be accurate enough ? 
Because it is a real time design for a Medical Product.

2. If we use kernel timers to invoke at particular time intervals using add_timer () how to  pass on to the application that the time has elapsed?

A piece of code demonstartion would be much more helpful to us 

Thanks & Regards,
Reefath Banu Rajali
Software Engineer
Larsen & Toubro 
Embedded Systems & Software
Mysore
India


