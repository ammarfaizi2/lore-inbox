Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315235AbSEGXDV>; Tue, 7 May 2002 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315251AbSEGXDU>; Tue, 7 May 2002 19:03:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35245 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315235AbSEGXDT>; Tue, 7 May 2002 19:03:19 -0400
Subject: x86 question: Can a process have > 3GB memory? 
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF4EFD903E.F8196584-ON87256BB2.007DEC69@boulder.ibm.com>
From: "Clifford White" <ctwhite@us.ibm.com>
Date: Tue, 7 May 2002 16:03:09 -0700
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 05/07/2002 05:03:18 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are working with a database that requires a large amount of memory
allocated by a single process.
This is on an Intel 32-bit platform.
We'd like to go > 3GB of memory per process.
Is this possible on a 32-bit machine? I have been reading the various
'highmem' discussions, but that's kernel page tables...
Or is this a glibc issue, and not proper for a kernel-list question?
Any pointers would be appreciated. The Intel ESMA (Extended Server Memory
Arch) page states that it's possible, but.....how?

cliffw
NUMA-Q
Technical Guy
1-503-578-4306


