Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUIOUjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUIOUjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUIOUhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:37:24 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:17406 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S267360AbUIOUfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:35:37 -0400
Date: Wed, 15 Sep 2004 22:33:49 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040915203349.GA15903@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com> <20040914184517.GA2655@k3.hellgate.ch> <20040914190747.GA9106@holomorphy.com> <20040915114430.GA28143@k3.hellgate.ch> <20040915200230.GA13621@k3.hellgate.ch> <20040915202028.GV9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915202028.GV9106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 13:20:28 -0700, William Lee Irwin III wrote:
> Try this again after applying my updates, which make it equivalent to the
> algorithms used internally by fs/proc/task_mmu.c.

That doesn't sound very interesting. The results are predictable. The
point of my previous message was that we can easily identify expensive
fields.

Ah well, compiling patched kernel anyway.

Roger
