Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbTF1BAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbTF1BAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:00:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:2646 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264660AbTF1BAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:00:07 -0400
Date: Fri, 27 Jun 2003 18:14:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: bcollins@debian.org, davidel@xmailserver.org, davem@redhat.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-Id: <20030627181432.61bf6f3a.akpm@digeo.com>
In-Reply-To: <35240000.1056760723@[10.10.2.4]>
References: <20030626.224739.88478624.davem@redhat.com>
	<21740000.1056724453@[10.10.2.4]>
	<Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com>
	<20030627.143738.41641928.davem@redhat.com>
	<Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com>
	<20030627213153.GR501@phunnypharm.org>
	<20030627162527.714091ce.akpm@digeo.com>
	<35240000.1056760723@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2003 01:14:22.0035 (UTC) FILETIME=[9B474230:01C33D12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
>  I think your suggestion of sending new bugs out to LKML has made a big
>  dent in the one<->one problem already. Replacing all the default owner 
>  fields with mailing lists (either existing ones or new ones) instead of 
>  individuals would be another step in that direction, though there may
>  be a few hurdles to deal with on the way to that.
> 
>  Yes, we probably also need an "email back in" interface as we've 
>  discussed before to take it up to many-many.

Both these things would help heaps - the tracking system then
becomes invisible, basically.  The best of both.  Can we make it so?
