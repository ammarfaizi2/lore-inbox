Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSILMfH>; Thu, 12 Sep 2002 08:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSILMfH>; Thu, 12 Sep 2002 08:35:07 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:58313 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315437AbSILMfG>;
	Thu, 12 Sep 2002 08:35:06 -0400
Subject: Re: netperf3 results on 2.5.25 kernel
To: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF21DA2F38.45AD0884-ON87256C32.0044DDC0@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Thu, 12 Sep 2002 07:39:01 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/12/2002 06:39:03 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I did a comparison test on 2.4.17, 2.5.25 stock kernels and on 2.5.25
>> with NAPI enabled e1000 driver using netperf3, tcp_stream 1 adapter
>> test using UNI kernels. The test setup/results can be found at:
>>
http://www-124.ibm.com/developerworks/opensource/linuxperf/netperf/results/july_02/netperf2.5.25results.htm


>On which machine(s) do you actually test the kernels? Source machine?
>Destination machine? Or both?

I am just catching up with my mail. Sorry about that.  I don't think
I understand your question completely. Let me answer, if I don't make
it clear ask me again.

The client and the server systems have the same level kernels. The CPU
utilization collected at server end is used to derive the throughput
scaled to CPU.  The throughput for tcp_stream reflects the rate of
transmits at the client and the rate of receives at the server.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




