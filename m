Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318996AbSH1Vs7>; Wed, 28 Aug 2002 17:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319002AbSH1Vs7>; Wed, 28 Aug 2002 17:48:59 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14481 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318996AbSH1Vs6>;
	Wed, 28 Aug 2002 17:48:58 -0400
Subject: IPV4 and IPV6 tcp_stream comparison
To: netdev@oss.sgi.com, linux-net@vger.kernel.org, usagi-users@linux-ipv6.org,
       linux-kernel@vger.kernel.org
Cc: "Bill Hartner" <bhartner@us.ibm.com>, "Venkata Jagana" <jagana@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF8FD51B6C.BAC47A60-ON87256C23.007274D4@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Wed, 28 Aug 2002 16:52:59 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/28/2002 03:52:55 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a comparison test of IPV4 and IPV6 using 2.4.17
kernel for IPV4 and 2.4.17 kernel+USAGI-linux24-s20020415-2.4.17.diff
patch running netperf3, tcp_stream 1 adapter, 2 adapters
test on UNI, SMP kernels using a 2-way machine.
The test setup/results/profile can be found at:
http://www-124.ibm.com/developerworks/opensource/linuxperf/netperf/results/may_02/netperf3_ipv6_2.4.17resutls.htm


Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




