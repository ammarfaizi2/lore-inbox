Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbTAJTti>; Fri, 10 Jan 2003 14:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTAJTti>; Fri, 10 Jan 2003 14:49:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:39624 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266298AbTAJTth> convert rfc822-to-8bit; Fri, 10 Jan 2003 14:49:37 -0500
X-Priority: 1 (High)
Importance: High
Subject: NGPT 2.2.0 RELEASED: TOPS LINUXTHREADS AND NPTL IN SCALABILITY AND
 PERFORMANCE
To: ibmltc-list@redhat.com, ibm-linux-announce@linux.ibm.com,
       ibm-linux-dev@linux.ibm.com, ibm-linux-tech@linux.ibm.com,
       ltc@linux.ibm.com, pthreads-announce@www-124.southbury.usf.ibm.com,
       pthreads-core@www-124.southbury.usf.ibm.com,
       pthreads-devel@www-124.southbury.usf.ibm.com,
       pthreads-users@www-124.southbury.usf.ibm.com
Cc: phil-list@redhat.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFD6D876A7.7D7E3A46-ON85256CAA.0068C7D5@us.ibm.com>
From: Bill Abt <babt@us.ibm.com>
Date: Fri, 10 Jan 2003 14:58:06 -0500
X-MIMETrack: Serialize by Router on D03NM144/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 01/10/2003 12:58:19
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NGPT - Next Generation POSIX Threading

NGPT Release 2.2.0, released today, 10 January 2003,  is the next release
of the "Next Generation"
of Linux pthreads support.  This release is fully suitable as a replacement
for LinuxThreads by either
a single user or group or an entire distribution.

In this release, the primary focus was performance.  Significant
performance and scalability enhance-
ments have been made to this release making it the fastest and most
scalable POSIX compliant
threads package available on the Linux platform.
                                                                             
                                                                             
                                                                             
 In this release, performance and scalability were the key focus of NGPT     
 developers.  Performance and scalability were improved to the point where   
 NGPT bests both LinuxThreads and the new NPTL threading package in          
 benchmarks.  No changes were made to the kernel patches and thanks to the   
 NPTL effort, all changes required to run NGPT on the latest 2.5.x kernels   
 are already included.                                                       
                                                                             
                                                                             
 Performance and scalability were measured using a benchmark program         
 developed by Sun Microsystems to "prove" that a 1:1 threading model is      
 better than the M:N threading model.  As can be seen in the benchmark       
 results NGPT is the performance and scalability leader on both a 2-way and  
 4-way machine running this benchmark.  The benchmark results can be found   
 on the NGPT website.  The benchmark itself can be downloaded from the Sun   
 Microsystems site.                                                          
                                                                             
                                                                             

The NGPT website can be found at
http://www-126.ibm.com/developerworks/opensource/pthreads.


