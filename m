Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131948AbRAOFSq>; Mon, 15 Jan 2001 00:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRAOFSh>; Mon, 15 Jan 2001 00:18:37 -0500
Received: from gw33.sw.com.sg ([203.120.9.33]:65500 "EHLO relay1.sw.com.sg")
	by vger.kernel.org with ESMTP id <S131948AbRAOFSZ>;
	Mon, 15 Jan 2001 00:18:25 -0500
X-Exchange-Loop: 1
thread-index: AcB+srA6OXwtWZjdS6G8ei25FELZKw==
Message-ID: <3A62884C.744B72AF@sw.com.sg>
Date: Mon, 15 Jan 2001 13:19:08 +0800
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
From: "Vlad Bolkhovitine" <vladb@sw.com.sg>
Importance: normal
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: ru,en
MIME-Version: 1.0
To: "Ray Bryant" <raybry@austin.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mmap()/VM problem in 2.4.0
In-Reply-To: <3A5EFB40.6080B6F3@sw.com.sg> <3A5F76A6.5B2A0E68@austin.ibm.com>
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2001 05:19:09.0151 (UTC) FILETIME=[B02ECEF0:01C07EB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tiotest/tiobench a new disk benchmark program written by a group of people led
by Mika Kuoppala. AFAIK, it is the only disk IO test, which is able to use
mmap(). You can find it on http://tiobench.sourceforge.net/ or
http://www.icon.fi/~mak/tiotest/tiobench-0.3.1.tar.gz. 

Regards,
Vlad

Ray Bryant wrote:
> 
> Your note to the kernel mailing list mentioned "tiotest".  This is a benchmark that I am not familiar with (and I work in a Linux
> peroformance group here in IBM).  Is this your code?  If not, where can I get a copy?
> 
> (I'm interested in VM performance problems among other things.)
> 
> --
> Best Regards,
> 
> Ray Bryant
> IBM Linux Technology Center
> raybry@austin.ibm.com
> 512-838-8538
> http://oss.software.ibm.com/developerworks/opensource/linux
> 
> We are Linux. Resistance is an indication that you missed the point.
> 
> "...the Right Thing is more important than the amount of flamage you need
> to go through to get there"
> --Eric S. Raymond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
