Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263224AbTCMX0K>; Thu, 13 Mar 2003 18:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263225AbTCMX0K>; Thu, 13 Mar 2003 18:26:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:42209 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263224AbTCMX0J>;
	Thu, 13 Mar 2003 18:26:09 -0500
Date: Thu, 13 Mar 2003 15:25:45 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-Id: <20030313152545.24ba9d46.akpm@digeo.com>
In-Reply-To: <m37kb27tt8.fsf@lexa.home.net>
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313142512.69f82864.akpm@digeo.com>
	<m37kb27tt8.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 23:30:57.0901 (UTC) FILETIME=[998A09D0:01C2E9B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> done
> done

Thanks!

> 
>  AM> c) It looks like EXT2FS_DEBUG broke.  Nobody uses that much, but
>  AM> we should fix and test it sometime.
> 
> I suggest this to be fixed in separate patch. are you?

Yes, that's fine.

> ...
> btw, what about minor bug in ext2 allocation code I posted recently?
> do you agree it needs to be fixed?

That's still in my inbox.  I do not silently drop stuff, but am sometimes
laggy.


