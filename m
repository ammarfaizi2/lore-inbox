Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318376AbSIKGg4>; Wed, 11 Sep 2002 02:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318389AbSIKGgz>; Wed, 11 Sep 2002 02:36:55 -0400
Received: from web9606.mail.yahoo.com ([216.136.129.185]:16181 "HELO
	web9606.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318376AbSIKGgz>; Wed, 11 Sep 2002 02:36:55 -0400
Message-ID: <20020911064142.51692.qmail@web9606.mail.yahoo.com>
Date: Tue, 10 Sep 2002 23:41:42 -0700 (PDT)
From: Sanjay Kumar <kumar_sanjai@yahoo.com>
Subject: Reducing memory footprint for embedded linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am reducing the memory usage of vmlinux used in embedded
system ( I am using Montavista Hardhat linux 2.4.2 kernel) . 
I am able to reduce some by allocating lesser memory to caches
(page_cache, buffer cache etc.. )
What all other areas I can look for reducing the memory usage. 
 
Please cc me as I am not subscribed to list

Thanks
sanjay

__________________________________________________
Yahoo! - We Remember
9-11: A tribute to the more than 3,000 lives lost
http://dir.remember.yahoo.com/tribute
