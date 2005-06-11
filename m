Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVFKQzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVFKQzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVFKQzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:55:09 -0400
Received: from mail.linicks.net ([217.204.244.146]:51470 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261739AbVFKQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:54:49 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 'hello world' module
Date: Sat, 11 Jun 2005 17:54:45 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506111754.46016.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> Nick Warne wrote:
>> 2.4.31, GCC 3.4.4
>> 
>> Build like:
>> 
>> gcc -D__KERNEL__ -I/usr/src/linux/include -DMODULE -Wall -O2 -c hello.c
>> -o hello.o
> 
> That compilation method will not work on 2.6. You have to use the kernel
> makefiles to build the module. See:
> 
> http://linuxdevices.com/articles/AT4389927951.html

I see.  Sorry for the bum steer; I haven't messed about with 2.6.x much in 
development - I am still [trying to learn] learning 2.4.x.

How do you guys keep up with it all?

Great link, thanks.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
