Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVDAV6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVDAV6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVDAVvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:51:20 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:12609 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262931AbVDAV3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 16:29:23 -0500
Message-ID: <39484.192.168.1.5.1112390815.squirrel@www.rncbc.org>
In-Reply-To: <20050401162843.GA9309@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
    <20050401104724.GA31971@elte.hu>
    <55598.195.245.190.93.1112357613.squirrel@www.rncbc.org>
    <20050401125219.GA2560@elte.hu>
    <8294.195.245.190.93.1112366538.squirrel@www.rncbc.org>
    <20050401150620.GA6618@elte.hu>
    <46028.195.245.190.93.1112370726.squirrel@www.rncbc.org>
    <20050401162843.GA9309@elte.hu>
Date: Fri, 1 Apr 2005 22:26:55 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "Steven Rostedt" <rostedt@goodmis.org>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Apr 2005 21:29:19.0489 (UTC) FILETIME=[DD293F10:01C53701]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> >> needs unknown symbol __compat_down_failed_interruptible
>>
>> Nope. Same error output as last report.
>
> does -43-04 work for you?
>

RT-V0.7.43-05 is now working for me. No quirks so far, on the UP laptop.
Building now for the SMP/HT desktop.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

