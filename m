Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271499AbSISQKr>; Thu, 19 Sep 2002 12:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271541AbSISQKr>; Thu, 19 Sep 2002 12:10:47 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:46801 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S271499AbSISQKq>; Thu, 19 Sep 2002 12:10:46 -0400
Message-ID: <20020919161018.1630.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, <phillips@arcor.de>,
       linux-kernel@vger.kernel.org
Cc: <akpm@digeo.com>
Date: Fri, 20 Sep 2002 00:10:18 +0800
Subject: Re: [chatroom benchmark version 1.0.1] Results
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@aracnet.com>
[...]
> > There's also some kind of hint that preemption improves throughput
> > here.
> 
> Any chance of doing two runs on exactly the same kernel, one with 
> preempt on, and the other with preempt off? That's a much nicer 
> hint ;-)
Yep! you are rigth, but I can performe this test only with 2.5.33 and 2.5.34.
2.5.36 oops at boot if the preemption is ON. Robert!!

But, do this test using local network produce results very variable (5-10 %).

Ciao,
           Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
