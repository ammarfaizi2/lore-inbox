Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbTCGSdB>; Fri, 7 Mar 2003 13:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbTCGSdB>; Fri, 7 Mar 2003 13:33:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:8595 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261703AbTCGSdA>;
	Fri, 7 Mar 2003 13:33:00 -0500
Date: Fri, 7 Mar 2003 10:43:33 -0800
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I for 2.5.64-mm1
Message-Id: <20030307104333.6f63c53a.akpm@digeo.com>
In-Reply-To: <20030307175700.GA2835@ca-server1.us.oracle.com>
References: <20030307175700.GA2835@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 18:43:23.0736 (UTC) FILETIME=[6EC6E580:01C2E4D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> 
> WimMark I report for 2.5.64-mm1
> 
> Runs with anticipatory scheduler:  547.28 580.69
> Runs with deadline scheduler:  1557.79 1360.52
> 

Boggle.

I have a patch in my inbox which increases NickMark I throughput by 400%, so
it should help this one.

Is the difference between 2.5.64 and 2.5.64-mm1 statistically significant? 
(It should be - the readahead changes).

