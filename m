Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291251AbSB0B3B>; Tue, 26 Feb 2002 20:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291247AbSB0B2v>; Tue, 26 Feb 2002 20:28:51 -0500
Received: from ark.dev.insynq.com ([216.174.202.133]:48908 "EHLO
	ark.dev.insynq.com") by vger.kernel.org with ESMTP
	id <S291251AbSB0B2j>; Tue, 26 Feb 2002 20:28:39 -0500
To: linux-kernel@vger.kernel.org, nkirsch@insynq.com
Subject: Re: Reproducible freeze on 2.4.18
Message-Id: <E16fsrU-0005Rc-00@ark.dev.insynq.com>
From: Nicholas Kirsch <nkirsch@insynq.com>
Date: Tue, 26 Feb 2002 17:26:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help! Using 2.4.18 (and verified as far back as .9) - I am getting a process freeze when an application does an fsync. I thought turning off HIGHMEM solved the issue, but I am now getting an identical freeze on an msync. Any advice would be greatly appreciated. Please CC to nkirsch@insynq.com. 
Thanks!
Nick
