Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUG0MdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUG0MdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 08:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUG0MdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 08:33:08 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:140 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S265226AbUG0M3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 08:29:41 -0400
Message-ID: <41064BB8.4F8B7543@tv-sign.ru>
Date: Tue, 27 Jul 2004 16:34:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] prio_tree iterator cleanup.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rajesh,

Rajesh Venkatasubramanian wrote:
>
> If you can post your 2nd and 3rd patches independent of your
> first patch, that will be great.

Ok, i'll do it at weekend.

> Please covert vma_prio_tree_next in arch/* directories if you
> plan to post a new version of your 3rd patch.

Oh, sorry. I promise, i will read man grep 3 times.

> However, your 1st patch is intrusive and I am not convinced
> that it improves the code very much.
> Overall I am inclined to leave the prio_tree code as it is.

Yes, i understand, it changes working code without real gain.
However, i will send it as 3rd patch, in the case you will
change you mind.

Thank you,
Oleg.
