Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbUDNMHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264068AbUDNMHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:07:39 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:60677 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264064AbUDNMHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:07:38 -0400
Date: Wed, 14 Apr 2004 20:12:33 +0800 (WST)
From: raven@themaw.net
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount after bad chdir
In-Reply-To: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0404142009500.1537@donald.themaw.net>
References: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Hugh Dickins wrote:

> After chdir (or chroot) to non-existent directory on 2.6.5-mm5, you
> can no longer unmount filesystem holding working directory (or root).
> 

Of course.

Excellent. Thanks very much.

Ian

