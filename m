Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUEFNFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUEFNFO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUEFNFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:05:14 -0400
Received: from [61.135.132.139] ([61.135.132.139]:39203 "EHLO
	websmtp02.sohu.com") by vger.kernel.org with ESMTP id S261718AbUEFNFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:05:09 -0400
Message-ID: <7475352.1083848708542.JavaMail.postfix@mx0.mail.sohu.com>
Date: Thu, 6 May 2004 21:05:08 +0800 (CST)
From: <dongzai007@sohu.com>
To: <linux-kernel@vger.kernel.org>
Subject: beginner of a driver-developer
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 61.49.100.222
X-Priority: 3
X-SHMOBILE: 0
X-SHBIND: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am a beginner of a driver-developer.
I got some problems.

you know some structs such as "file_operation" were defined in Header Files.when I define a struct in .C files,i always got errors below:

fops has an incomplete type
storage size of 'fops' isn't known

In my .C files , I defined as followed:

.....................
struct file_operation fops;
.....................

How can i solve this sort of problems. Thank you.

