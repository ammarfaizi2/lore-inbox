Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbTIDFMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 01:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264699AbTIDFMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 01:12:42 -0400
Received: from dyn-ctb-203-221-72-2.webone.com.au ([203.221.72.2]:2820 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264670AbTIDFMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 01:12:38 -0400
Message-ID: <3F569641.9090905@cyberone.com.au>
Date: Thu, 04 Sep 2003 11:32:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
References: <20030902231812.03fae13f.akpm@osdl.org> <20030904010852.095e7545.diegocg@teleline.es>
In-Reply-To: <20030904010852.095e7545.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Diego Calleja García wrote:

>El Tue, 2 Sep 2003 23:18:12 -0700 Andrew Morton <akpm@osdl.org> escribió:
>
>  
>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/
>>
>>. Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
>>  in evaluating the stability, efficacy and relative performance of Nick's
>>  work.
>>
>>  We're looking for feedback on the subjective behaviour and on the usual
>>  server benchmarks please.
>>    
>>
>
>
>I must say that this one doesn't feel nice under heavy gcc load. Huge mp3
>skips that didn't happened before, big pauses in X...gcc starves anything else.
>-mm4 was better there.
>  
>

Hmm... what's heavy gcc load?


