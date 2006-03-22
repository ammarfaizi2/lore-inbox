Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWCVXEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWCVXEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWCVXEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:04:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:31895 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751422AbWCVXEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:04:02 -0500
Message-ID: <4421D7D5.6010809@garzik.org>
Date: Wed, 22 Mar 2006 18:03:49 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 02/34] mm: page-replace-kconfig-makefile.patch
References: <20060322223107.12658.14997.sendpatchset@twins.localnet> <20060322223128.12658.81399.sendpatchset@twins.localnet>
In-Reply-To: <20060322223128.12658.81399.sendpatchset@twins.localnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Introduce the configuration option, and modify the Makefile.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

For future patch posting, -please- use a sane email subject.

The email subject is used as a one-line summary for each changeset. 
While "page-replace-kconfig-makefile.patch" certainly communicates 
information, its much less easy to read than normal.  It also makes the 
git changelog summary (git log $branch..$branch2 | git shortlog) that 
Linus posts much uglier:

Peter Zijlstra:
	[PATCH] mm: kill-page-activate.patch
	[PATCH] mm: page-replace-kconfig-makefile.patch
	[PATCH] mm: page-replace-insert.patch
	[PATCH] mm: page-replace-use_once.patch

See http://linux.yyz.us/patch-format.html for more info.

Regards,

	Jeff


