Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUBEKio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbUBEKio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:38:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263937AbUBEKin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:38:43 -0500
Date: Thu, 5 Feb 2004 02:40:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: jmorris@redhat.com, aviro@redhat.com, sds@epoch.ncsc.mil,
       linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, chrisw@osdl.org
Subject: Re: [PATCH] (3/3) SELinux context mount support - SELinux changes.
Message-Id: <20040205024016.281a1c5a.akpm@osdl.org>
In-Reply-To: <200402051017.i15AHA99025783@turing-police.cc.vt.edu>
References: <Xine.LNX.4.44.0402040953280.4796-100000@thoron.boston.redhat.com>
	<200402051017.i15AHA99025783@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> This isn't the first time that we've had patches go by with nice explanitory
>  text that doesn't make it into the kernel tree.  Does anybody have a good
>  idea on what we can/should do about these?  Even just dropping them into
>  one big Documentation/hints file might be good enough.
> 

All that text is lovingly shovelled into the changelogs.  They're damn hard
to get at via the bk web interface but with `bk revtool' it's a snap.  Go
to a line in a .c file, double-click on it, see the diffview and the full
changelog.

