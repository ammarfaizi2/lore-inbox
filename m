Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbTLMUnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 15:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbTLMUnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 15:43:25 -0500
Received: from garfield.cs.mun.ca ([134.153.48.1]:14270 "EHLO
	garfield.cs.mun.ca") by vger.kernel.org with ESMTP id S265289AbTLMUnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 15:43:24 -0500
Message-ID: <3157.134.153.205.13.1071348202.squirrel@www.cs.mun.ca>
Date: Sat, 13 Dec 2003 17:13:22 -0330 (NST)
Subject: Writing to NTFS and kernel 2.6-test11
From: pprice@cs.mun.ca
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have read that it is possible to change a file as long as it is the same
size using write(2) and mmap(2). I don't seem to be able to make this
work. I was wondering if someone has some code that will allow me to do
this. Any input would be greatly appreciated.

Thanks,
Paul

   Paul Price
   PC Consultant II
   Computer Science Department
   Memorial University of Newfoundland
