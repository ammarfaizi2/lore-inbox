Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbTBVBsw>; Fri, 21 Feb 2003 20:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267765AbTBVBsw>; Fri, 21 Feb 2003 20:48:52 -0500
Received: from dial-ctb05215.webone.com.au ([210.9.245.215]:40708 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267761AbTBVBsv>;
	Fri, 21 Feb 2003 20:48:51 -0500
Message-ID: <3E56D954.90803@cyberone.com.au>
Date: Sat, 22 Feb 2003 12:58:44 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.62-mm2
References: <20030220234733.3d4c5e6d.akpm@digeo.com> <200302212048.09802.tomlins@cam.org>
In-Reply-To: <200302212048.09802.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:

>On February 21, 2003 02:47 am, Andrew Morton wrote:
>
>>So this tree has three elevators (apart from the no-op elevator).  You can
>>select between them via the kernel boot commandline:
>>
>>        elevator=as
>>        elevator=cfq
>>        elevator=deadline
>>
>
>Has anyone been having problems booting with 'as'?  It hangs here at the point
>root gets mounted readonly.  cfq works ok.
>
What sort of disk controller arrangement and drivers are you using?

