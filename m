Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265644AbSJSSCZ>; Sat, 19 Oct 2002 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265645AbSJSSCZ>; Sat, 19 Oct 2002 14:02:25 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:43918 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S265644AbSJSSCZ>; Sat, 19 Oct 2002 14:02:25 -0400
Date: Sat, 19 Oct 2002 14:08:15 -0400
Message-Id: <200210191808.OAA32554@k42.watson.ibm.com>
From: bob <bob@watson.ibm.com>
To: torvalds@transmeta.com
CC: karim@opersys.com, linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: LTT ready for 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
     I know now is a busy time and wanted to make sure the possibility of
including LTT was considered and not lost amidst the frenzy.  For a while
now I have been working with the RAS team at IBM and with Karim Yaghmour to
streamline LTT and make it perform well on MPs.  We have addressed all the
concerns raised by yourself, Ingo, and others from previous postings.  If
there remains concern, it is also possible for one to disable tracing.
Some of the features we put into LTT came from ideas we prototyped in K42
(www.research.ibm.com/K42) which in turn was developed based on my
experience writing a tracing infrastructure for IRIX while working for SGI,
and other's experiences with AIX's tracing facilities.
     LTT is a valuable aspect in allowing developers using Linux to
understand their application's and the system's behavior.  It serves to
strengthen Linux's RAS capabilities and would be great to get included into
2.5.  Thanks.

-bob

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

