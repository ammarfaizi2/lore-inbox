Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbSJLBZn>; Fri, 11 Oct 2002 21:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSJLBZm>; Fri, 11 Oct 2002 21:25:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:8595 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262616AbSJLBZm>; Fri, 11 Oct 2002 21:25:42 -0400
Date: Fri, 11 Oct 2002 18:29:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
Message-ID: <1749543871.1034360975@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.33.0210111009170.4030-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0210111009170.4030-100000@maxwell.earthlink.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes some of the missed handle_sysrq functions not updated.
> please apply.

Are you going to have early console support (ie printk from before
what is now console_init) done before the freeze, or should I just 
submit our version?

Thanks,

Martin.

