Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313362AbSDKIup>; Thu, 11 Apr 2002 04:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313531AbSDKIuo>; Thu, 11 Apr 2002 04:50:44 -0400
Received: from smtp.cs.curtin.edu.au ([134.7.1.4]:18959 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S313362AbSDKIun>; Thu, 11 Apr 2002 04:50:43 -0400
Message-Id: <5.1.0.14.2.20020411164152.02fb87a0@pop.cs.curtin.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 11 Apr 2002 16:50:41 +0800
To: linux-kernel@vger.kernel.org
From: David Shirley <dave@cs.curtin.edu.au>
Subject: The process of NFS mounting?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm not sure that this is the correct list for this question,
so I apologise if you think so.

Basically I want to understand the process of NFS mounting
in terms of network activity and transactions from client
to server.

 From my understanding basically the client requests the mountd
port from the servers portmapper.

Then the client talks to mountd

etc etc etc..

Well the problem I have is that it seems that mountd is trying to
establish a new UDP connection (yeah yeah i know...) to the mount
client process. Is this what is supposed to happen?

Cheers
Dave





/-----------------------------------
David Shirley
System's Administrator
Computer Science - Curtin University
(08) 9266 2986
-----------------------------------/

