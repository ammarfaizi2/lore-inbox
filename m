Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292237AbSBZRWV>; Tue, 26 Feb 2002 12:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292249AbSBZRWM>; Tue, 26 Feb 2002 12:22:12 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:41710 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S292237AbSBZRWC>; Tue, 26 Feb 2002 12:22:02 -0500
Message-ID: <3C7BBFBB.27A2E9FB@austin.ibm.com>
Date: Tue, 26 Feb 2002 11:02:51 -0600
From: Jon Grimm <jgrimm@austin.ibm.com>
Organization: IBM Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17lksctp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sctpdev <sctp-developers-list@cig.mot.com>
CC: sctp-announce-list@cig.mot.com, linux-kernel@vger.kernel.org,
        La Monte Henry Piggy Yarroll <piggy@baqaqi.chi.il.us>,
        linux-net@vgr.kernel.org
Subject: [ANNOUNCE] lksctp Version 2.4.17-0.4.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I'd like to announce the latest Developer's release Linux Kernel SCTP
project.  See below and the project website,
http://www.sf.net/projects/lksctp, for details.

Thanks,
Jon Grimm  


-------------------------------------------------------------
Version 2.4.17-0.4.4 of the Developers' Release of the SCTP
Kernel Reference Implementation is available from

        http://www.sourceforge.net/projects/lksctp/

The Kernel Reference is loosely based on the SCTP User Space Reference
by Randy Stewart and Qiaobing Xie.  For this reason it is covered by
the GPL.  

lksctp-2_4_17_0_4_4:

Patch 515054 INIT retransmission (jgrimm)
Patch 511394 Invalid StreamId tests (daisyc)
	     README suggestions (baqaqi)
Bug   519410 test_kernel spinlock initialization (sridhar)
Patch 520992 Enable COOKIE-ECHO bundling (jgrimm)linu
Patch 520627 Fix autobind twice bug (daisyc)
Patch 520755 A couple bugs from Debug Memory Allocations (sridhar)
Patch 521216 Fix bind_addrs_to_raw calling kmalloc(GFP_KERNL) on int.
(jgrimm)

lksctp-2_4_17-0_4_3:
New          Update to 2.4.17 (sridhar)
Patch 512680 Frame test bindx for IPv6 (hui)
Patch 510317 Failing testcase for source addr bug (daisyc)

lksctp-2_4_1-0_4_3:
Patch 511028 New CRC32C  (dinakarjb)
Patch 510797 Sendmsg w/associd (jgrimm)
Patch 499262 Testcase for stream negotiation (daisyc) 
Bug   473322 Sendmsg insists on msg_name (jgrimm) 


To subscribe to the SCTP Kernel Reference Implementation announcements
list, please send a message to

	To: majordomo@cig.mot.com 
	subscribe sctp-announce-list

All postings to the announcement list are moderated.

If you would like to follow the day-to-day development of the SCTP
kernel, please send a message to

	To: majordomo@cig.mot.com 
	subscribe sctp-developers-list

Post messages for the developers (including bug reports) to

	sctp-developers-list@cig.mot.com

If you wish to participate in development, please subscribe to the
developers' list, drop a note to sctp-developers-list.
