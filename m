Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263253AbTCSXWA>; Wed, 19 Mar 2003 18:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbTCSXWA>; Wed, 19 Mar 2003 18:22:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:20943 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263253AbTCSXWA>;
	Wed, 19 Mar 2003 18:22:00 -0500
Date: Wed, 19 Mar 2003 17:38:08 -0800
From: Andrew Morton <akpm@digeo.com>
To: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm2
Message-Id: <20030319173808.7fb1c204.akpm@digeo.com>
In-Reply-To: <200303192317.22103.cb-lkml@fish.zetnet.co.uk>
References: <200303192317.22103.cb-lkml@fish.zetnet.co.uk>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 23:32:44.0403 (UTC) FILETIME=[D77F7430:01C2EE6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Baylis <cb-lkml@fish.zetnet.co.uk> wrote:
>
> 
> I'm getting quite a lot of audio skips with this one. 2.5.64-mm8 was the 
> last one I tested and it was very good.
> 
> 2.5.64-mm8 works fine with pretty much any thud load I throw at it, but thud 
> 3 is enough to cause some skips with 2.5.65-mm2. Thud 5 causes serious 
> starvation problems to the whole desktop.

Please test 2.5.65 base.
