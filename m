Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbUKHSuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbUKHSuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKHSsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:48:51 -0500
Received: from bay10-f46.bay10.hotmail.com ([64.4.37.46]:63272 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261174AbUKHSlK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:41:10 -0500
X-Originating-IP: [146.229.163.26]
X-Originating-Email: [getarunsri@hotmail.com]
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: problem with printk--  somebody please help
Date: Tue, 09 Nov 2004 00:10:13 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY10-F469WbbjykeNX00014ef5@hotmail.com>
X-OriginalArrivalTime: 08 Nov 2004 18:41:04.0775 (UTC) FILETIME=[80C22170:01C4C5C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I am new to the kernel world and would be very glad if somebody could
help me with this problem.

I am unable to do printk or even a macro call like rdtsc()...(for
reading the time stamp counter) from within the "activate_task"
function on a kernel with smp support.But these work under the main
schedule() function.

I was able to do all these i.e., inside "activate_task" on a kernel
without smp support.Can anybody suggest a solution as to what could be
the problem??

somebody please help.

Thanks
Arun

_________________________________________________________________
The all-new MSN Search. Get fast and precise results. 
http://search.msn.co.in Try it now!

