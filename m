Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318789AbSHWMxb>; Fri, 23 Aug 2002 08:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSHWMxb>; Fri, 23 Aug 2002 08:53:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60316 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318789AbSHWMx2>; Fri, 23 Aug 2002 08:53:28 -0400
Subject: Re: netperf3 results on 2.5.25 kernel
To: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF3BE9157D.2B6CD78B-ON87256C1E.0046E571@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Fri, 23 Aug 2002 07:56:49 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/23/2002 06:56:50 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric wrote...
>> I did a comparison test on 2.4.17, 2.5.25 stock kernels and on 2.5.25
>> with NAPI enabled e1000 driver using netperf3, tcp_stream 1 adapter
>> test using UNI kernels. The test setup/results can be found at:
>>
http://www-124.ibm.com/developerworks/opensource/linuxperf/netperf/results/july_02/netperf2.5.25results.htm


>On which machine(s) do you actually test the kernels? Source machine?
>Destination machine? Or both?

On both the server and the client, I used the respective kernels.
However I used the cpu usage from the server since my objective
is to stress the server in this test.



Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




