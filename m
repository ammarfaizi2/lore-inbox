Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbTCZHfN>; Wed, 26 Mar 2003 02:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbTCZHfN>; Wed, 26 Mar 2003 02:35:13 -0500
Received: from [12.47.58.111] ([12.47.58.111]:24790 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S261498AbTCZHfM>; Wed, 26 Mar 2003 02:35:12 -0500
Date: Tue, 25 Mar 2003 23:46:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 crashes and lockups (modutils & gdm-binary)
Message-Id: <20030325234654.4da45b2e.akpm@digeo.com>
In-Reply-To: <3E8155B1.5000506@cox.net>
References: <3E8155B1.5000506@cox.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2003 07:46:17.0200 (UTC) FILETIME=[C8942F00:01C2F36B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David van Hoose <davidvh@cox.net> wrote:
>
> I never had any problems with any kernel before 2.5.66 (beta or stable) 
> locking up or crashing.
> I activated the NMI watchdog and still have been getting some really 
> massive lockups, but now I'm getting some crash dumps. Attached is a 
> group of snippets from my /var/log/messages from a couple of bootups.
> 
> If any information is needed, just ask.
> 

What module is being modprobed at the time of the crash?
