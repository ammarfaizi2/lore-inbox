Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbTDNVVT (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTDNVVS (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:21:18 -0400
Received: from [12.47.58.203] ([12.47.58.203]:25084 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263825AbTDNVUW (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:20:22 -0400
Date: Mon, 14 Apr 2003 14:31:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm2
Message-Id: <20030414143141.632da899.akpm@digeo.com>
In-Reply-To: <20030414174818.GR4917@ca-server1.us.oracle.com>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
	<20030414174818.GR4917@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 21:32:05.0267 (UTC) FILETIME=[4B607630:01C302CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
> > . I've changed the 32-bit dev_t patch to provide a 12:20 split rather than
> >   16:16.  This patch is starting to drag a bit and unless someone stops me I
> >   might just go submit the thing.
> 
> 	Cool, but before you go off and push, maybe kick the appropriate
> folks about making the 32/64 decision?
> 

It'll be 32+32.  I was just trolling.
