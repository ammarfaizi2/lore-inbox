Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbSI3SyP>; Mon, 30 Sep 2002 14:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSI3SyP>; Mon, 30 Sep 2002 14:54:15 -0400
Received: from packet.digeo.com ([12.110.80.53]:3519 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261271AbSI3SyO>;
	Mon, 30 Sep 2002 14:54:14 -0400
Message-ID: <3D989F25.F6605540@digeo.com>
Date: Mon, 30 Sep 2002 11:59:49 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 2.0.9
References: <Pine.LNX.4.44L.0209301357500.22735-100000@imladris.surriel.com> from "Rik van Riel" at Sep 30, 2002 01:59:56 PM <200209301843.g8UIhjZ151770@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 18:59:33.0990 (UTC) FILETIME=[83D36860:01C268B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> > Procps is the package containing various system monitoring tools, like
> > ps, top, vmstat, free, kill, sysctl, uptime and more.  After a long
> > period of inactivity procps maintenance is active again and suggestions,
> > bugreports and patches are always welcome on the procps list.
> 
> It should be mentioned that this is a fork off of an obsolete
> code base. I was keeping quiet in hopes of resolving the fork.
> Many of the "fixes" have been in Debian's procps for years.
> 
> Debian's code has been fully maintained for years. It is
> available in CVS at SourceForge. Let us know what you think
> of the new "top" program.
> 

Does it support the /proc/stat cleanups which I have queued,
and the additional /proc/meminfo fields?
