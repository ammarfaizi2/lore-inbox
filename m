Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132627AbRC2Azx>; Wed, 28 Mar 2001 19:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132631AbRC2Aze>; Wed, 28 Mar 2001 19:55:34 -0500
Received: from dsl081-146-215.chi1.dsl.speakeasy.net ([64.81.146.215]:12036
	"EHLO manetheren.eigenray.com") by vger.kernel.org with ESMTP
	id <S132627AbRC2Az0>; Wed, 28 Mar 2001 19:55:26 -0500
Date: Wed, 28 Mar 2001 18:52:24 -0600 (CST)
From: Paul Cassella <pwc@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Hangs under 2.4.2-ac{18,19,24} that do not happen under -ac12.
In-Reply-To: <Pine.SGI.3.96.1010328165432.10707A-100000@fsgi626.americas.sgi.com>
Message-ID: <Pine.LNX.4.21.0103281836370.780-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier today, I wrote

> and no sysrq keys other than B worked; I didn't hear disk activity
> after S, and the disks weren't unmounted.  Nothing made it to the

Of course, when I rebooted this time (after SysRQ S,U,B), all the
filesystems were clean.

Nothing in the logs this time either though.

> When I get home and reboot (following this most recent hang :( ), I'll
> put the diff, .config, and more stuff from /proc at

>   http://manetheren.eigenray.com/~fortytwo/crash-12-18.2

This is now there.

-- 
Paul Cassella


