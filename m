Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTBQLSh>; Mon, 17 Feb 2003 06:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbTBQLSh>; Mon, 17 Feb 2003 06:18:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:50680 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266998AbTBQLSg>;
	Mon, 17 Feb 2003 06:18:36 -0500
Date: Mon, 17 Feb 2003 03:29:26 -0800
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: cloos@jhcloos.com, linux-kernel@vger.kernel.org, adam@yggdrasil.com,
       kernel@kolivas.org
Subject: Re: 2.5.61-mm1
Message-Id: <20030217032926.6c13a912.akpm@digeo.com>
In-Reply-To: <20030217113856.GC1112@in.ibm.com>
References: <20030214231356.59e2ef51.akpm@digeo.com>
	<m365rlf5ia.fsf@lugabout.jhcloos.org>
	<20030215162904.6ba8fdc2.akpm@digeo.com>
	<20030217113856.GC1112@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2003 11:28:28.0999 (UTC) FILETIME=[B1AA8570:01C2D677]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> The following patch should enable smalldevfs to work with dcache_rcu.

I suspected this might happen ;)  Many thanks.

