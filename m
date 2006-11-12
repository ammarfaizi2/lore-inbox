Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753245AbWKLVns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbWKLVns (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 16:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbWKLVns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 16:43:48 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:49901 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1753245AbWKLVnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 16:43:47 -0500
Date: Sun, 12 Nov 2006 22:40:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Burman Yan <yan_952@hotmail.com>,
       trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATH] Replace kmalloc+memset with kzalloc 1/17
In-Reply-To: <20061112102554.c9d422b7.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.61.0611122239010.4951@yvahk01.tjqt.qr>
References: <BAY20-F1803D00EDD5FC1FD65726ED8F50@phx.gbl>
 <20061112173103.GA14005@flint.arm.linux.org.uk> <20061112102554.c9d422b7.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > This is the first part of the patches I made that do trivial change of 
>> > replacing
>> > kmalloc and memset with kzalloc
>> 
>> Please follow the guidelines in SubmittingPatches in the kernel source
>> when sending patches out.  You must not expect everyone here to read
>> each of the attachments in your messages in detail to work out whether
>> they need to do something with it or not.
>
>You should also use a different subject for each one,


And if possible, attach it using a text/plain mime type or text/x-patch 
instead of application/octet-stream. Because if it's octet-stream, PINE 
won't let me view it in an instant (gotta export it first).


	-`J'
-- 
