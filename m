Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbTE1LNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264678AbTE1LNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:13:32 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:26406 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264677AbTE1LNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:13:32 -0400
Date: Wed, 28 May 2003 04:27:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: axboe@suse.de, kernel@kolivas.org, matthias.mueller@rz.uni-karlsruhe.de,
       manish@storadinc.com, andrea@suse.de, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-Id: <20030528042700.47372139.akpm@digeo.com>
In-Reply-To: <200305281305.44073.m.c.p@wolk-project.de>
References: <3ED2DE86.2070406@storadinc.com>
	<20030528105029.GS845@suse.de>
	<20030528035939.72a973b0.akpm@digeo.com>
	<200305281305.44073.m.c.p@wolk-project.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 11:26:47.0463 (UTC) FILETIME=[06745B70:01C3250C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
>
> Does the attached one make sense?

Nope.

Guys, you're the ones who can reproduce this.  Please spend more time
working out which chunk (or combination thereof) actually fixes the
problem.  If indeed any of them do.  

I'm suspecting that Con's fingers slipped.


