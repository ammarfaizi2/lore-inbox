Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSLME5a>; Thu, 12 Dec 2002 23:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSLME5a>; Thu, 12 Dec 2002 23:57:30 -0500
Received: from fmr02.intel.com ([192.55.52.25]:6099 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261416AbSLME53>; Thu, 12 Dec 2002 23:57:29 -0500
Message-ID: <000901c2a265$3ad3a260$6901a8c0@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <fault-injection-developer@sourceforge.net>, <lclaudio@conectiva.com.br>,
       <acme@conectiva.com.br>, <olive@conectiva.com.br>,
       <riel@conectiva.com.br>
Subject: [ANNOUNCE] Fault-Injection Test Harness Project
Date: Thu, 12 Dec 2002 21:05:16 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fault-Injection Test Harness Project
-------------------------------------

I am pleased to announce the formation of a new project for developing a
test harness for inserting faults into a running kernel.  The project is
based at http://fault-injection.sf.net, with a bitkeeper tree hosted at
http://fault-injection.bkbits.net:8080/linux-2.5/, and an IRC channel named
#fi on 206.103.61.170. (The DNS entry for the IRC address is about to
change, but the number should stay the same.)

The project started out to try to validate that a kernel driver was
acceptable for a carrier environment (the "mystical" hardened driver) :).
Now, it has morphed to building a general tool for inserting faults into
any part of the kernel to see if the kernel reacts in a way the test
developer expects.  We have kind of straw man design with some
_very_ early prototype work, but for the most part things are just 
now getting started. I know there are some people on this list that 
have some considerable experience in fault injection on other Unix's, 
and some of you have hinted to me in emails that you might be 
interested in creating some kind of fault injection tool for Linux.  
I just hope I can entice you into joining our efforts (even if you 
only want to give us some directional guidance.)

As mentioned we are developing off of a clone of the 2.5 tree that we
periodically sync.  A CVS tree and snapshots are available from the
sourceforge site for those that do not use bitkeeper, but they will always
lag behind.

        -rustyl



