Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271695AbTHHQks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271698AbTHHQks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:40:48 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:50398 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S271695AbTHHQkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:40:47 -0400
Date: Fri, 8 Aug 2003 18:40:45 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-ac3 and 16Gigs of ram?
Message-ID: <20030808164045.GA18750@louise.pinerecords.com>
References: <20030808162813.GI8950@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030808162813.GI8950@rdlg.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Robert.L.Harris@rdlg.net]
> 
>   I was building a new kernel for a production mailserver.  I took the old
> config from 2.4.18 and did a "make oldconfig" in the 2.4.21-ac3.  A
> couple new values, compile, install reboot and reboot and reboot, etc.
> 
>   After a good bit of recompiling it seems that enabling the 64Gig
> option instead of the 4Gig causes the machine to reboot after it counts
> out it's procs.
> 
>   This machine only has 4Gigs of memory but is otherwise identicle to
> the production server which has 16Gigs.

It's "identical."

> Thoughts?

Try 2.4.21 vanilla, 2.4.22-rc1 or a recent ac kernel like 2.4.22-pre10-ac1,
please.

-- 
Tomas Szepe <szepe@pinerecords.com>
