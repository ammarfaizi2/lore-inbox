Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131464AbRCUJhn>; Wed, 21 Mar 2001 04:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbRCUJhX>; Wed, 21 Mar 2001 04:37:23 -0500
Received: from brunel.uk1.vbc.net ([194.207.2.8]:40972 "EHLO
	brunel.uk1.vbc.net") by vger.kernel.org with ESMTP
	id <S131464AbRCUJhS>; Wed, 21 Mar 2001 04:37:18 -0500
From: Alastair Stevens <ans@vbc.net>
Organization: VBCnet GB Ltd
Date: Wed, 21 Mar 2001 09:37:58 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: re: clustering
MIME-Version: 1.0
Message-Id: <01032109375802.16305@s2.uk1.vbc.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have multiple Gateway 166's that I would like to try and experiment 
> with Linux in a clustered environment. Any Advise?
> 
>   Bill Tomasiewicz
>   Computer Specialist    

Hi - try MOSIX, a very cool-looking clustering solution for Linux, 
applied as a kernel patch to 2.2 kernels. The site is at:
   
       http://www.mosix.cs.huji.ac.il/

There are other solutions out there, but this one looks pretty promising 
to me. I'm aware of others who are about to implement it, though I have 
no direct experience myself.

Hope this helps.
Alastair

-- 
Alastair Stevens
Network Engineer
VBCnet GB Ltd
.............................................................
ans@vbc.net        0117 929 1316 (ext 317)        www.vbc.net
