Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313882AbSD1G7N>; Sun, 28 Apr 2002 02:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314360AbSD1G7M>; Sun, 28 Apr 2002 02:59:12 -0400
Received: from wind.he.net ([216.218.129.2]:60676 "EHLO wind.he.net")
	by vger.kernel.org with ESMTP id <S313882AbSD1G7M>;
	Sun, 28 Apr 2002 02:59:12 -0400
Date: Sat, 27 Apr 2002 23:55:41 -0700
Mime-Version: 1.0 (Apple Message framework v481)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: 2.5.9,2.5.10 kernel compile, +SMP?
From: "Ron Pagani / San Francisco / San Jose, CA" <lists@ronpagani.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F4439967-5A74-11D6-B3D0-0030657B7B46@ronpagani.com>
X-Mailer: Apple Mail (2.481)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks:

Compile config question...

Single processor machine (Pentium III)

SMP comes default "ON" in my 2.5.10 and 2.5.9 config; why is it that if 
I turn it off (since I'm only using one processor) the build breaks?  I 
can post the part it chokes on (I recall something regarding 
cpu_number)...

I this a broken config issue, or is someone/thing have a SMP dependency 
in the 2.5 series?

TIA
Ron

