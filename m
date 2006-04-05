Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWDEXA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWDEXA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWDEXA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:00:59 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:21387 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S932121AbWDEXA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:00:59 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200604052257.k35Mv2oi010302@wildsau.enemy.org>
Subject: Re: Q on audit, audit-syscall
In-Reply-To: <20060405225535.GO15997@sorel.sous-sol.org>
To: Chris Wright <chrisw@sous-sol.org>
Date: Thu, 6 Apr 2006 00:57:02 +0200 (MET DST)
CC: Valdis.Kletnieks@vt.edu, Kyle Moffett <mrmacman_g4@mac.com>,
       Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's a decent README with the audit (userspace) source.  And the
> actual message format is documented in source code only AFAIK.

ok. thanks to all of you. I wasn't aware that netlink_audit is the
way to go and the others (/dev/audit, LAuS from IBM & SuSE) are obsolete.

and now, good night!

