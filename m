Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264477AbTCXWo2>; Mon, 24 Mar 2003 17:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264479AbTCXWo1>; Mon, 24 Mar 2003 17:44:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:7841 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264477AbTCXWnU>;
	Mon, 24 Mar 2003 17:43:20 -0500
Date: Mon, 24 Mar 2003 16:58:57 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block/inode allocation for EXT3
Message-Id: <20030324165857.6e548b1f.akpm@digeo.com>
In-Reply-To: <m3llz490ii.fsf@lexa.home.net>
References: <20030323040439.7a432edb.akpm@digeo.com>
	<m3llz490ii.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 22:54:14.0091 (UTC) FILETIME=[4A8291B0:01C2F258]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> hi!
> 
> this time, concurrent block/inode allocation for EXT3 against 2.5.65.

And the inode allocator changes look fine, thanks.  It is time to test this
puppy.

