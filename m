Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264620AbTHVVPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTHVVPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:15:12 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:19825 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264770AbTHVVPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:15:05 -0400
Message-ID: <3F46886B.6000801@sbcglobal.net>
Date: Fri, 22 Aug 2003 16:17:31 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>, Voluspa <lista1@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O17int
References: <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <200308210723.42789.kernel@kolivas.org> <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net> <3F454532.4030200@sbcglobal.net> <1061510950.3f455f26b14fa@kolivas.org>
In-Reply-To: <1061510950.3f455f26b14fa@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My last reply didn't make it to the list due to an html attachment.  
Mozilla is supposed to strip those but apparently does not sometimes...

Con Kolivas wrote:

>Umm. You didn't mention which kernel/patch? I seem to recall you were using 
>Osomething but which?
>  
>
For the record, that's 2.6.0-test3-mm2 + O16.3int

>
>If this is Osomething, can you tell me when it started doing this and what 
>vanilla does.
>  
>
Again, for posterity, this started with mm2, mm1 is similar to vanilla 
except it has better interactivity.  I've been running vanilla overnight 
and today but haven't found any cases where it stalls like mm2 does.


