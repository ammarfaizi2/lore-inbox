Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbULQBHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbULQBHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbULQBHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:07:23 -0500
Received: from bay23-f9.bay23.hotmail.com ([64.4.22.59]:3684 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262673AbULQBHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 20:07:11 -0500
Message-ID: <BAY23-F98CF7851CF6ECD3CD6D8DCAAF0@phx.gbl>
X-Originating-IP: [80.15.132.11]
X-Originating-Email: [mariabelliti@hotmail.com]
From: "maria belliti" <mariabelliti@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Paging and process (partial) loading
Date: Fri, 17 Dec 2004 01:06:26 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 17 Dec 2004 01:07:10.0215 (UTC) FILETIME=[BC224170:01C4E3D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I wish to be personally CC'ed the answers/comments posted to the list in 
response to this

post


for a system which supports virtual memory concepts, the OS will load
initially some pages from the process address space for execution.
my first question is there any command to get the process physical
memory address or at least the logical?
can we know which pages are loaded?

is that right that despite the possibiliy of a large memory space
availability, windows and may be other os can still use the disk as
repository and perform some page replacements which has an impact on
the process execution?

is there a reason for that, why os can use the physical memory instead

thanks

_________________________________________________________________
Want to block unwanted pop-ups? Download the free MSN Toolbar now!  
http://toolbar.msn.co.uk/

