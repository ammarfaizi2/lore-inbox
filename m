Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318845AbSICRTf>; Tue, 3 Sep 2002 13:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318846AbSICRTe>; Tue, 3 Sep 2002 13:19:34 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:46792 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id <S318845AbSICRTd>; Tue, 3 Sep 2002 13:19:33 -0400
Mime-Version: 1.0
Message-Id: <a05111606b99a9fda24c5@[129.98.90.227]>
In-Reply-To: <1030093049.5911.9.camel@irongate.swansea.linux.org.uk>
References: <a05111608b98b96373cce@[129.98.90.227]>
 <1030090864.5932.5.camel@irongate.swansea.linux.org.uk> 
 <a05111609b98ba20903b0@[129.98.90.227]>
 <1030093049.5911.9.camel@irongate.swansea.linux.org.uk>
Date: Tue, 3 Sep 2002 13:24:04 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: SMP Netfinity 340 hangs under 2.4.19
Cc: Martin.Bligh@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding this hang issue, I just had the vanilla 2.4.19 lockup, so 
it looks like the problem is not with the patches. Any ideas on how 
troubleshoot it further?

>On Fri, 2002-08-23 at 09:47, Maurice Volaski wrote:
>  > I haven't tried plain 2.4.19 yet. Should I have reason to not trust
>>  these patches?
>
>In the sense that they are not tested by the majority of 2.4.19 users
>its always worth checking that.
>
>>  So could this be taken to mean the issue is most likely software
>>  (presumably kernel)-related?
>
>It normally points to a kernel locking error


-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
