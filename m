Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264125AbSIVMdY>; Sun, 22 Sep 2002 08:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264139AbSIVMdY>; Sun, 22 Sep 2002 08:33:24 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:17563 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264125AbSIVMdX>; Sun, 22 Sep 2002 08:33:23 -0400
Message-ID: <20020922123738.30022.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 22 Sep 2002 20:37:38 +0800
Subject: Re: [chatroom benchmark version 1.0.1] Results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
someone suggested me to report other information and not only the average (I have no time to write a script in order to evaluate the dev...any help?)

Therefore here it goes the full log:

2.5.33_total.results:Average throughput : 60402 messages per second
2.5.33_total.results:Average throughput : 63981 messages per second
2.5.33_total.results:Average throughput : 60271 messages per second
2.5.33_total.results:Average throughput : 61403 messages per second
2.5.33_total.results:Average throughput : 61235 messages per second
2.5.33_total.results:Average throughput : 60603 messages per second
2.5.33_total.results:Average throughput : 61258 messages per second
2.5.33_total.results:Average throughput : 61675 messages per second
2.5.33_total.results:Average throughput : 62447 messages per second
2.5.33_total.results:Average throughput : 64523 messages per second

2.5.36-preemption_total.results:Average throughput : 58717 messages per second
2.5.36-preemption_total.results:Average throughput : 62171 messages per second
2.5.36-preemption_total.results:Average throughput : 63255 messages per second
2.5.36-preemption_total.results:Average throughput : 60643 messages per second
2.5.36-preemption_total.results:Average throughput : 61854 messages per second
2.5.36-preemption_total.results:Average throughput : 63547 messages per second
2.5.36-preemption_total.results:Average throughput : 55841 messages per second
2.5.36-preemption_total.results:Average throughput : 62911 messages per second
2.5.36-preemption_total.results:Average throughput : 55490 messages per second
2.5.36-preemption_total.results:Average throughput : 64343 messages per second

2.5.36_total.results:Average throughput : 60695 messages per second
2.5.36_total.results:Average throughput : 60356 messages per second
2.5.36_total.results:Average throughput : 59959 messages per second
2.5.36_total.results:Average throughput : 61132 messages per second
2.5.36_total.results:Average throughput : 60486 messages per second
2.5.36_total.results:Average throughput : 60378 messages per second
2.5.36_total.results:Average throughput : 63030 messages per second
2.5.36_total.results:Average throughput : 60431 messages per second
2.5.36_total.results:Average throughput : 60063 messages per second
2.5.36_total.results:Average throughput : 62057 messages per second

2.5.37-preemption_total.results:Average throughput : 60660 messages per second
2.5.37-preemption_total.results:Average throughput : 62788 messages per second
2.5.37-preemption_total.results:Average throughput : 61604 messages per second
2.5.37-preemption_total.results:Average throughput : 62324 messages per second
2.5.37-preemption_total.results:Average throughput : 63011 messages per second
2.5.37-preemption_total.results:Average throughput : 61596 messages per second
2.5.37-preemption_total.results:Average throughput : 61944 messages per second
2.5.37-preemption_total.results:Average throughput : 59562 messages per second
2.5.37-preemption_total.results:Average throughput : 62385 messages per second
2.5.37-preemption_total.results:Average throughput : 63087 messages per second

2.5.38-preemption_total.results:Average throughput : 63051 messages per second
2.5.38-preemption_total.results:Average throughput : 60065 messages per second
2.5.38-preemption_total.results:Average throughput : 61488 messages per second
2.5.38-preemption_total.results:Average throughput : 63471 messages per second
2.5.38-preemption_total.results:Average throughput : 62200 messages per second
2.5.38-preemption_total.results:Average throughput : 61631 messages per second
2.5.38-preemption_total.results:Average throughput : 64894 messages per second
2.5.38-preemption_total.results:Average throughput : 63893 messages per second
2.5.38-preemption_total.results:Average throughput : 63127 messages per second
2.5.38-preemption_total.results:Average throughput : 61565 messages per second

And here it goes the average:
2.5.33-preemption.average:Average throughput: 60943.9 messages per second
2.5.33.average:Average throughput: 61779.8 messages per second
2.5.36-preemption.average:Average throughput: 60877.2 messages per second
2.5.36.average:Average throughput: 60858.7 messages per second
2.5.37-preemption.average:Average throughput: 61896.1 messages per second
2.5.38-preemption.average:Average throughput: 62538.5 messages per second

Ciao,
          Paolo

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
