Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUB0JTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 04:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUB0JTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 04:19:21 -0500
Received: from ztxmail02.ztx.compaq.com ([161.114.1.206]:51204 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261750AbUB0JTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 04:19:15 -0500
Message-ID: <403F0C06.2070809@toughguy.net>
Date: Fri, 27 Feb 2004 14:51:10 +0530
From: Raj <obelix123@toughguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sonika Sachdeva <sonikam@magnum.barc.ernet.in>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux scheduler Implementation details
References: <403F0B66.A7920233@magnum.barc.ernet.in>
In-Reply-To: <403F0B66.A7920233@magnum.barc.ernet.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonika Sachdeva wrote:

>Hello List,
>
>I want to simulate the Linux Scheduler, ie Calculate the priorities, counters
>and define to some extent how much time a given process will take to execute on
>the system. Can anyone suggest some pointers?
>
>Thank you
>Sonika
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Documentation/sched-design.txt
Documentation/sched-coding.txt

and oh ofcourse, kernel/sched.c :-)

/Raj

