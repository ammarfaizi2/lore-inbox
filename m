Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAIKUK>; Tue, 9 Jan 2001 05:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbRAIKUB>; Tue, 9 Jan 2001 05:20:01 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:22483 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S129561AbRAIKTx>; Tue, 9 Jan 2001 05:19:53 -0500
Message-ID: <3A5AE556.A3854B83@oracle.com>
Date: Tue, 09 Jan 2001 11:17:58 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Silviu Marin-Caea <silviu@delrom.ro>
CC: linux-kernel@vger.kernel.org, rlug@lug.ro
Subject: Re: Failure building 2.4 while running 2.4.  Success in building 2.4 
 while running 2.2.
In-Reply-To: <20010109111247.397581ea.silviu@delrom.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silviu Marin-Caea wrote:
> 
> I have RedHat7, glibc-2.2-9, gcc-2.96-69.
> 
> I can build 2.4.0 while running kernel 2.2.16.
> 
> If I try to rebuild 2.4.0 while running the new kernel, I get random
> compiler errors.
> 
> It happens on two machines.  One of them runs 2.4.0-test12, the other
> 2.4.0.  Both of them with the updates above mentioned.
> 
> I know this is a RedHat issue, but it may be useful to know for some.

I know this isn't since I already built 2.4.0-ac2 and -ac3 on this
 laptop and never got any compiler error :)

[asuardi@princess asuardi]$ rpm -q glibc gcc
glibc-2.2-9
gcc-2.96-69

random compiler errors => bad hardware. On two machines ? Yes.

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p6/2.4.0 glibc-2.2 gcc-2.96-69 binutils-2.10.1.0.4
Oracle: Oracle8i 8.1.7.0.0 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
