Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbTCOLZ0>; Sat, 15 Mar 2003 06:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbTCOLZ0>; Sat, 15 Mar 2003 06:25:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:1673 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261421AbTCOLZZ>;
	Sat, 15 Mar 2003 06:25:25 -0500
Date: Sat, 15 Mar 2003 03:35:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm7
Message-Id: <20030315033550.32bc34cd.akpm@digeo.com>
In-Reply-To: <20030315112935.1841.qmail@linuxmail.org>
References: <20030315112935.1841.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 11:35:40.0109 (UTC) FILETIME=[015E2FD0:01C2EAE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> ----- Original Message ----- 
> From: Andrew Morton <akpm@digeo.com> 
> Date: 	Sat, 15 Mar 2003 01:17:58 -0800 
> To: linux-kernel@vger.kernel.org, linux-mm@kvack.org 
> Subject: 2.5.64-mm7 
>  
> > . Niggling bugs in the anticipatory scheduler are causing problems.  I've 
> >   reset the default to elevator=deadline until we get these fixed up. 
>  
> I haven't still experienced those bugs using mm6 and AS. 

Me either.

> Is there an easy way to reproduce them? 

If there was, they'd be fixed.

