Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVDAPxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVDAPxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVDAPxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:53:36 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:14275 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261785AbVDAPxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:53:34 -0500
Message-ID: <46028.195.245.190.93.1112370726.squirrel@www.rncbc.org>
In-Reply-To: <20050401150620.GA6618@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
    <20050401104724.GA31971@elte.hu>
    <55598.195.245.190.93.1112357613.squirrel@www.rncbc.org>
    <20050401125219.GA2560@elte.hu>
    <8294.195.245.190.93.1112366538.squirrel@www.rncbc.org>
    <20050401150620.GA6618@elte.hu>
Date: Fri, 1 Apr 2005 16:52:06 +0100 (WEST)
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
X-OriginalArrivalTime: 01 Apr 2005 15:53:33.0469 (UTC) FILETIME=[F5328CD0:01C536D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Rui Nuno Capela wrote:
>
>> > thx - i've uploaded -43-01 which should fix this.
>> >
>>
>> Now it's dying-on-the-beach:
>
>> needs unknown symbol __compat_down_failed_interruptible
>
> ok - does -43-02 work any better?
>

Nope. Same error output as last report.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

