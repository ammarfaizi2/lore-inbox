Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbQKGJmq>; Tue, 7 Nov 2000 04:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130880AbQKGJmh>; Tue, 7 Nov 2000 04:42:37 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:52377 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S130645AbQKGJm0>; Tue, 7 Nov 2000 04:42:26 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: forop066@zaz.com.br
cc: linux-kernel@vger.kernel.org
Message-ID: <80256990.00354C2B.00@d06mta06.portsmouth.uk.ibm.com>
Date: Tue, 7 Nov 2000 07:52:09 +0000
Subject: Re: Calling module symbols from inside the kernel !
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We have a generic way of doing this which we are about to release - called
GKHI (Generalised Kernel Hooks Interface) would you like a copy to test?


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
