Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270822AbSISI1O>; Thu, 19 Sep 2002 04:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270881AbSISI1O>; Thu, 19 Sep 2002 04:27:14 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:59558 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S270822AbSISI1N>; Thu, 19 Sep 2002 04:27:13 -0400
Message-ID: <20020919083034.24458.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <phillips@arcor.de>, linux-kernel@vger.kernel.org
Cc: <akpm@digeo.com>
Date: Thu, 19 Sep 2002 16:30:34 +0800
Subject: Re: [chatroom benchmark version 1.0.1] Results
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Phillips <phillips@arcor.de>

[...]
> There's also some kind of hint that preemption improves throughput
> here.
I'm not so sure, but I'm not a developer,
just looking to the number:
 
> > 2.5.34.results:Average throughput : 62941 messages per second
> > 2.5.36.results:Average throughput : 60858 messages per second
2.5.34 and 2.5.36 have more or less the same performances... (2.5.34 is preemption ON, 2.5.36 is OFF)

There is an improovement in throughput in 2.5.3* against 2.4.*, and this is _good_ ;-)

Ciao,
       Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
