Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264866AbSKEPnh>; Tue, 5 Nov 2002 10:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSKEPnh>; Tue, 5 Nov 2002 10:43:37 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2765 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264866AbSKEPnf>;
	Tue, 5 Nov 2002 10:43:35 -0500
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
To: "Geoff Gustafson" <geoff@linux.co.intel.com>
Cc: "Dan Kegel" <dkegel@ixiacom.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF1545C7D1.9A1FE355-ON86256C68.00565997@pok.ibm.com>
From: "Stephanie Glass" <sglass@us.ibm.com>
Date: Tue, 5 Nov 2002 09:49:39 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and RM_DEBUG |October 24, 2002) at 11/05/2002 10:49:51 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Geoff,
The LTP would be happy to have anyone in the Linux community donate test
cases.  This includes any POSIX tests.
The LTP would not be advertised as a POSIX compliance test, that would be
up to LSB to handle.  These tests
would only increase the overall LTP api coverages.

Does your group own these tests?  Do you want to donate them to the LTP?

Stephanie

Linux Technology Center
 IBM, 11400 Burnet Road, Austin, TX  78758
 Phone: (512) 838-9284   T/L: 678-9284  Fax: (512) 838-3882
 E-Mail: sglass@us.ibm.com


                                                                                                                             
                      "Geoff Gustafson"                                                                                      
                      <geoff@linux.co.i        To:       "Dan Kegel" <dkegel@ixiacom.com>, "Linux Kernel Mailing List"       
                      ntel.com>                 <linux-kernel@vger.kernel.org>                                               
                                               cc:       Stephanie Glass/Austin/IBM@IBMUS                                    
                      11/04/2002 06:04         Subject:  Re: [ANNOUNCE] Open POSIX Test Suite                                
                      PM                                                                                                     
                                                                                                                             
                                                                                                                             



> You are about to duplicate http://ltp.sf.net

My understanding is that LTP is focused on current mainline kernel testing,
while this project's initial concern is areas that are not currently in
Linux
like POSIX message queues, semaphores, and full support for POSIX threads.
I see
this as being used to evaluate different implementations that are being
considered for inclusion in the kernel, glibc, etc.

This project is concerned with the POSIX APIs regardless of where they are
implemented (kernel, glibc, etc.). Thus it can focus on POSIX, independent
of
implementation. This project will be more concerned with traceability back
to
the POSIX specification, and completeness of coverage, than I would expect
from
LTP.

That said, there is some overlap, and an exchange of test cases between the
projects may be very useful.

I've copied Stephanie from LTP to get her reaction.

-- Geoff Gustafson

These are my views and not necessarily those of my employer.






