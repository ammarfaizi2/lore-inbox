Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLEIHu>; Tue, 5 Dec 2000 03:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbQLEIHk>; Tue, 5 Dec 2000 03:07:40 -0500
Received: from mgw-x3.nokia.com ([131.228.20.26]:48051 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S129340AbQLEIHZ> convert rfc822-to-8bit;
	Tue, 5 Dec 2000 03:07:25 -0500
Message-ID: <9524EA4E18D6D2119FEA0008C7C5A006BE4A77@lneis01nok>
From: Peter.Ronnquist@nokia.com
To: linux-kernel@vger.kernel.org
Subject: shared memory, mmap not recommended?
Date: Tue, 5 Dec 2000 09:36:50 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In a recent posting Linus Torvalds mentioned
(http://marc.theaimsgroup.com/?l=linux-kernel&m=97598683318724&w=2) :

> (otherwise I'll just end up disabling shared mmap - I doubt anybody really
uses it anyway, but it would be more polite to just support it).

I was thinking about using mmap for shared mememory in my program, but now I
am reconsidering. 
Is the System V or Posix mechanism for shared memory a better(it will be
supported in 2.4) choice?

(I am not subscribed to the mailing list so please CC your eventual reply)

BR
Peter Rönnquist            
Software Engineer
Nokia Home Communications
email: peter.ronnquist@nokia.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
