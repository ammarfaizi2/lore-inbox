Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTBQBS6>; Sun, 16 Feb 2003 20:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbTBQBS6>; Sun, 16 Feb 2003 20:18:58 -0500
Received: from packet.digeo.com ([12.110.80.53]:59110 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261448AbTBQBS5>;
	Sun, 16 Feb 2003 20:18:57 -0500
Date: Sun, 16 Feb 2003 17:29:42 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Performance of ext3 on large systems
Message-Id: <20030216172942.06b0ddba.akpm@digeo.com>
In-Reply-To: <66390000.1045442686@[10.10.2.4]>
References: <66390000.1045442686@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2003 01:28:49.0690 (UTC) FILETIME=[EC53A7A0:01C2D623]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> (look at system time ... eeek!)

Can we just say that ext3's talents lie elsewhere?

I've got some stuff which helps a bit, but nobody has had the time
to implement the significant overhaul which is needed here.

noatime would help.
