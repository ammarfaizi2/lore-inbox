Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268713AbTBZLQm>; Wed, 26 Feb 2003 06:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268714AbTBZLQm>; Wed, 26 Feb 2003 06:16:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:41927 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268713AbTBZLQm>;
	Wed, 26 Feb 2003 06:16:42 -0500
Date: Wed, 26 Feb 2003 03:27:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] add missing global_flush_tlb() after
 change_page_attr() calls
Message-Id: <20030226032727.69686001.akpm@digeo.com>
In-Reply-To: <200302261217.29084.schlicht@uni-mannheim.de>
References: <200302261217.29084.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2003 11:26:52.0383 (UTC) FILETIME=[F5CBD6F0:01C2DD89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> 
> P.S.: I sent this patch on friday yet, but I think friday is a bad day for 
> sending patches... ;-)

Your patch was merged on Monday :)
