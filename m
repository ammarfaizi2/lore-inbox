Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268800AbUJKLWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268800AbUJKLWH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUJKLWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:22:07 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:34530 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S268800AbUJKLWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:22:03 -0400
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <C6322819-1B77-11D9-8CAE-000393B3D4EC@stanford.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Linux Kernel list <linux-kernel@vger.kernel.org>
From: Can Sar <csar@stanford.edu>
Subject: Page/Buffer Cache: Traversing Dirty Buffers
Date: Mon, 11 Oct 2004 04:22:02 -0700
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know this is not really the right place for asking general questions, 
but I have read the source and searched the web and LKML archives for 2 
days without much avail.
I am writing a driver for a research project, and need to be able to 
traverse all dirty buffers in the buffer cache, for this device. I have 
read through buffer.c and several other files a dozen times, but have 
not been able to pin down exactly how to get access to the buffer 
cache. If someone could point any files that I should look at, to get a 
pointer to all the dirty buffers associated with a device, I would be 
very happy.

Thank you very much for your help,
Can Sar

