Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136917AbREKHAo>; Fri, 11 May 2001 03:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136913AbREKHAf>; Fri, 11 May 2001 03:00:35 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:64575 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S136917AbREKHAZ>; Fri, 11 May 2001 03:00:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: rico-linux-kernel@patrec.com
Subject: Re: 2.4.3 Kernel Freeze with highmem BUG at highmem.c:155 - CRASH
Date: Fri, 11 May 2001 09:00:43 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010510225133.3897.qmail@pc7.prs.nunet.net>
In-Reply-To: <20010510225133.3897.qmail@pc7.prs.nunet.net>
MIME-Version: 1.0
Message-Id: <01051109004300.07057@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I reported the same sluggishness problem on Feb 25.  Capsule summary
> is 64GB option does not work.  I was easily able to reproduce the
> sluggishness in 2.4.2, but need to test again for 2.4.4.  See if your
> problem goes away with the 4GB option.

Hi

Thanks for the advice, I am however using the 4GB setting already. I find it 
difficult to reproduce the results as the freeze happens at various times 
when I am wokring on the console. I do however suspect that it is related to 
AACRAID array write activity....

Regards
MarCin

-- 
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
