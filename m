Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291148AbSB0BYv>; Tue, 26 Feb 2002 20:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291172AbSB0BYl>; Tue, 26 Feb 2002 20:24:41 -0500
Received: from ark.dev.insynq.com ([216.174.202.133]:45836 "EHLO
	ark.dev.insynq.com") by vger.kernel.org with ESMTP
	id <S291148AbSB0BYY>; Tue, 26 Feb 2002 20:24:24 -0500
To: linux-kernel@vger.kernel.org, nkirsch@insynq.com
Subject: Re: Reproducible freeze on 2.4.18
Message-Id: <E16fsnE-0005RR-00@ark.dev.insynq.com>
From: Nicholas Kirsch <nkirsch@insynq.com>
Date: Tue, 26 Feb 2002 17:22:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help! Using 2.4.18 (and verified as far back as .9) - I am getting a process freeze when an application does an fsync. Turning off HIGHMEM (the box has 2GB ram) solves the issue. Is there anyone who is interested in learning more about this situation? Please CC to nkirsch@insynq.com. 
Thanks!
