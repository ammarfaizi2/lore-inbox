Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313916AbSDZMMV>; Fri, 26 Apr 2002 08:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313917AbSDZMMU>; Fri, 26 Apr 2002 08:12:20 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:30121 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S313916AbSDZMMU> convert rfc822-to-8bit; Fri, 26 Apr 2002 08:12:20 -0400
Message-ID: <F9CC1B4C20A0D411A99E00508BDFA6A203D8AB00@enoasnt101.eto.ericsson.se>
From: =?iso-8859-1?Q?Eldor_R=F8dseth_=28ETO=29?= 
	<Eldor.Rodseth@eto.ericsson.se>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: =?iso-8859-1?Q?Eldor_R=F8dseth_=28ETO=29?= 
	<Eldor.Rodseth@eto.ericsson.se>
Subject: SCHED_FIFO and SCHED_RR in 2.4.7-10custom kernel
Date: Fri, 26 Apr 2002 14:01:12 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear all!

I am posting this request, hoping for a reply from someone that has experienced similar problems.

My application uses the possibility to change scheduling mechanism. When changing from 
SCHED_OTHER to SCHED_FIFO or SCHED_RR, my application causes the whole Linux
PC to "hang". Prior to launching my own application, I launch a "superbash" application with
higher priority than my own application. But I am not able to switch to the window where this
"superbash" application is running to kill my own application. The PC simply does not respond
to any input from the keyboard.

I have used this mechanism before, and I am quite confident that this worked under kernel 2.4.2.
Are you aware of anything that could explain this behaviour?

Thanks.

Regards, 
Eldor Rødseth
Technical Coordinator/SPoC
CN2.0 DFU@ETO
Cellular: +47 950 86888

