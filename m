Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVCCBXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVCCBXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVCCBXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:23:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:49804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261271AbVCCBVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:21:23 -0500
Date: Wed, 2 Mar 2005 17:20:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302172049.72a0037f.akpm@osdl.org>
In-Reply-To: <20050303011151.GJ10124@redhat.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<20050303011151.GJ10124@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> So what was broken with the 2.6.8.1 type of 'hotfix kernel' release ?

That's an alternative, of course.

But that _is_ a branch, and does need active forward- and (mainly)
backward-porting work.

There's nothing wrong with it per-se, but it becomes a "stabilised version
of the kernel.org tree" or even a "production version of the kernel.org
tree".  In other words it's somewhere on the line between the mainline
kernel.org tree and a distribution.  How far along that line should it
be positioned?
