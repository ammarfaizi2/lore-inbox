Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156589AbPIZVUG>; Sun, 26 Sep 1999 17:20:06 -0400
Received: by vger.rutgers.edu id <S156488AbPIZVTp>; Sun, 26 Sep 1999 17:19:45 -0400
Received: from smtp13.bellglobal.com ([204.101.251.52]:47089 "EHLO smtp13.bellglobal.com") by vger.rutgers.edu with ESMTP id <S156476AbPIZVTc>; Sun, 26 Sep 1999 17:19:32 -0400
Date: Sun, 26 Sep 1999 17:16:07 -0400 (EDT)
From: Gary Simmons <darshu@sympatico.ca>
To: Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: PPPoE
Message-ID: <Pine.LNX.4.10.9909261715200.2222-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

My ADSL service provider is in the transition to switiching to a PPPoE
service, currently both DHCP and PPPoE work but within a month I will be
forced to use PPPoE. They have provided a userspace PPPoE driver and have
distributed both the binary and source thereto. The problem however is
despite the driver working, it uses a monsterous 30% CPU usage. I recall
hearing of an effort to develop the PPPoE kernelspace driver that was much
faster, what is the status of this? I could provide the source to the
driver I speak of however it has a license agreement which appears to
state that even thoguht he source is provided you may not use it for any
useful purpose other than compiling it to obtain the binary.  Any further
information would be appreciated.
-Gary Simmons




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
