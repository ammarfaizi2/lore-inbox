Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292045AbSCIJvQ>; Sat, 9 Mar 2002 04:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292592AbSCIJvG>; Sat, 9 Mar 2002 04:51:06 -0500
Received: from insgate.stack.nl ([131.155.140.2]:32780 "HELO skynet.stack.nl")
	by vger.kernel.org with SMTP id <S292045AbSCIJuz>;
	Sat, 9 Mar 2002 04:50:55 -0500
Date: Sat, 9 Mar 2002 10:50:53 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.6: IPv6 fails to initialize
In-Reply-To: <874rken8ik.fsf@devron.myhome.or.jp>
Message-ID: <20020309104503.I12051-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.5.6 comes with the next error:

Failed to initialize the ICMP6 control socket (err -97).

I have not found any kernel settings that affect this error, it happens
both with IPv6 compiled in kernel and loaded as module.

Jos


