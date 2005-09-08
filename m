Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVIHM5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVIHM5q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVIHM5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:57:46 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:3978 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932506AbVIHM5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:57:45 -0400
Message-ID: <43203543.1000604@comcast.net>
Date: Thu, 08 Sep 2005 08:57:39 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1 X86_64: All 32bit programs segfault
References: <431FB5FF.1030700@comcast.net>	<200509080600.39368.ak@suse.de>	<431FC7DA.6090309@comcast.net> <20050908014436.6edd2f53.akpm@osdl.org>
In-Reply-To: <20050908014436.6edd2f53.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>> it works fine.
>>    
>>
>
>I can't reproduce this with the current -mm lineup.  I compiled up a 32-bit
>app on x86 and transferred that across.
>
>Maybe it got fixed.  Please test 2.6.13-mm2, which appears to be an hour or
>two away.  If it still fails then I'd need a recipe (including URLs and
>stuff) with which to reproduce it please.
>  
>
You need  a program which uses threads - NPTL ones I suspect.
 Normal programs work fine even on my setup.
Any way I will give -mm2 a try and see.

Parag
