Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUCZWYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUCZWYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:24:39 -0500
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:31690 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S261378AbUCZWYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:24:36 -0500
Message-ID: <1080339875.8f2cd36818efd@system.cs.fsu.edu>
Date: Fri, 26 Mar 2004 17:24:35 -0500
From: khandelw@cs.fsu.edu
To: linux-kernel@vger.kernel.org
Subject: logging in kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 128.186.120.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I am a graudate student at Florida State University. My friends and my self
are planning to implement a kernel logger for linux kernel (real-time systems).
We are new to linux kernel programming and we have not done kernel programming.
    We believe right now most of the system are using printk. We want to write a
tool which can be used for debugging as well as logging of data in the future.
Following are the things that we have in mind so far.

1. Implement the logging daemon or the server as a periodic task in the
real-time system.
2. Have an api which looks similar to printk
3. Have an option to specify the write the network card or console or a
dedicated device.
4. Use it for checkpointing in distributed system.


I am not sure whether such a tool is required but I believe it will give me a
taste of kernel programming.

Any suggestions would be highly appreciated.

Thanking you all in anticipation.
-- Amit Khandelwal




