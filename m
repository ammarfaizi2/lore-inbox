Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTAORvT>; Wed, 15 Jan 2003 12:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbTAORvT>; Wed, 15 Jan 2003 12:51:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:2461 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266886AbTAORvS>;
	Wed, 15 Jan 2003 12:51:18 -0500
Date: Wed, 15 Jan 2003 10:01:02 -0800
From: Andrew Morton <akpm@digeo.com>
To: Robert Macaulay <robert_macaulay@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.57 IO slowdown with CONFIG_PREEMPT enabled
Message-Id: <20030115100102.0c8a6a27.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301151106340.21210-100000@ping.us.dell.com>
References: <Pine.LNX.4.44.0301151106340.21210-100000@ping.us.dell.com>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2003 18:00:05.0796 (UTC) FILETIME=[EF377640:01C2BCBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Macaulay <robert_macaulay@dell.com> wrote:
>
> Is this expected behaviour now?

Judging by the coffee dribbles on my monitor: no.

Thanks for the detailed report.  Let me crunch on that.


