Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVACApI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVACApI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVACApI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:45:08 -0500
Received: from bay14-f8.bay14.hotmail.com ([64.4.49.8]:63131 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S261358AbVACApC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:45:02 -0500
Message-ID: <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl>
X-Originating-IP: [80.15.132.11]
X-Originating-Email: [tonyosborne_a@hotmail.com]
From: "tony osborne" <tonyosborne_a@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Main CPU- I/O CPU interaction
Date: Mon, 03 Jan 2005 00:44:36 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 03 Jan 2005 00:45:00.0963 (UTC) FILETIME=[74DC3F30:01C4F12D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wish to be personally CC'ed the answers/comments posted to the list in 
response to this post .


The I/O devices are equipped with dedicated processor to free the  main CPU 
from doing the low level I/O operations. However, if i am editing and 
updating a big size file and i want to save
it afterwards, i  notice my PC getting blocked while saving the file which 
theoritically should NOT happen as it is up to the I/O device processor and 
not the main CPU to save the data into the disk; the main CPU could switch 
to another process after giving the high level command -save-to the device 
processor; so why the main CPU is blocked while saving such big size files

thanks

_________________________________________________________________
It's fast, it's easy and it's free. Get MSN Messenger today! 
http://www.msn.co.uk/messenger

