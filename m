Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTH2VAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTH2U7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:59:52 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:57575 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262361AbTH2U5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:57:42 -0400
Date: Fri, 29 Aug 2003 16:57:36 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 4G/4G preempt on vstack
In-Reply-To: <Pine.LNX.4.44.0308292151480.1816-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0308291657030.2390-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Aug 2003, Hugh Dickins wrote:

> This patch seems to fix that (ran successfully overnight on test4-mm1,
> will run over the weekend on test4-mm3-1).  Please cast a critical eye
> over it, I expect Ingo or someone else will find it can be improved.

good catch - patch looks good.

	Ingo

