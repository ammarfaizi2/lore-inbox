Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262615AbRE3Fqb>; Wed, 30 May 2001 01:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbRE3FqV>; Wed, 30 May 2001 01:46:21 -0400
Received: from [203.143.19.4] ([203.143.19.4]:52242 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262619AbRE3FqQ>;
	Wed, 30 May 2001 01:46:16 -0400
Date: Wed, 30 May 2001 11:12:21 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Generating valid random .configs
Message-ID: <Pine.LNX.4.21.0105301102560.282-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recently, I posted a request here to send your .config files and I
received a good number of them. (thanks!).

Now I want to generate even more different configurations, and a random
.config generator would be ideal. If I write a program which randomly
outputs "y", "m" and "n" and pipe its output through make config, will the
generated .configs always compile? Yes. the best thing is to go ahead and
try it (which I am doing at the moment) but I like to know the theoretical
answer;)

Thanks in advance.

Regards,

Anuradha

----------------------------------
http://www.bee.lk/people/anuradha/


