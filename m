Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbTCSXl3>; Wed, 19 Mar 2003 18:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbTCSXl3>; Wed, 19 Mar 2003 18:41:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:15056 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261211AbTCSXlO>;
	Wed, 19 Mar 2003 18:41:14 -0500
Date: Wed, 19 Mar 2003 17:57:26 -0800
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2
Message-Id: <20030319175726.59d08fba.akpm@digeo.com>
In-Reply-To: <20030319232812.GJ2835@ca-server1.us.oracle.com>
References: <20030319232812.GJ2835@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 23:52:02.0239 (UTC) FILETIME=[899F34F0:01C2EE72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> WimMark I report for 2.5.65-mm2
> 
> Runs:  1374.22 1487.19 1437.26
> 

That is with elevator=as?

Is this a statistically significant difference from elevator=deadline?

