Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263274AbTCUGN2>; Fri, 21 Mar 2003 01:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbTCUGN2>; Fri, 21 Mar 2003 01:13:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:8637 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263274AbTCUGN2>;
	Fri, 21 Mar 2003 01:13:28 -0500
Date: Thu, 20 Mar 2003 22:23:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: Linux-kernel@vger.kernel.org, torvalds@transmeta.com, ak@suse.com,
       rml@tech9.net
Subject: Re: [PATCH] arch-independent syscalls to return long
Message-Id: <20030320222358.454a1f4f.akpm@digeo.com>
In-Reply-To: <3E7AAD0C.B8CB2926@verizon.net>
References: <3E7AAD0C.B8CB2926@verizon.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2003 06:23:39.0770 (UTC) FILETIME=[69A7A5A0:01C2EF72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <randy.dunlap@verizon.net> wrote:
>
> Hi,
> 
> I posted this about 1 month ago (as [RFC]), to no avail.
> However, tonight Andi needs it for pause() [which is failing
> on x86_64], and Robert Love mentioned converting the affinity
> syscalls.  I had already done them, so here they are again.
> 

Thanks.  Is that all of them done now?
