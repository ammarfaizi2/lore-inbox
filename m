Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbTCTXne>; Thu, 20 Mar 2003 18:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCTXmc>; Thu, 20 Mar 2003 18:42:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:23986 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262659AbTCTXl4>;
	Thu, 20 Mar 2003 18:41:56 -0500
Date: Thu, 20 Mar 2003 17:58:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2 (now with deadline)
Message-Id: <20030320175805.1625dbcc.akpm@digeo.com>
In-Reply-To: <20030320204041.GO2835@ca-server1.us.oracle.com>
References: <20030320204041.GO2835@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2003 23:52:48.0920 (UTC) FILETIME=[CFDBE980:01C2EF3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> 
> WimMark I report for 2.5.65-mm2
> 
> Runs (antic):  1374.22 1487.19 1437.26
> Runs (deadline):  1238.58 1537.36 1513.04

The averages of these are equal.  Can we safely conclude that this is fixed
up now?

