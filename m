Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264707AbTE1Mk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTE1Mk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:40:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59825 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264707AbTE1MkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:40:25 -0400
Date: Wed, 28 May 2003 14:53:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528125312.GV845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305281331.26959.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Marc-Christian Petersen wrote:
> On Wednesday 28 May 2003 13:27, Andrew Morton wrote:
> 
> Hi Akpm,
> 
> > > Does the attached one make sense?
> > Nope.
> nm.
> 
> > Guys, you're the ones who can reproduce this.  Please spend more time
> > working out which chunk (or combination thereof) actually fixes the
> > problem.  If indeed any of them do.
> As I said, I will test it this evening. ATM I don't have time to
> recompile and reboot. This evening I will test extensively, even on
> SMP, SCSI, IDE and so on.

May I ask how you are reproducing the bad results? I'm trying in vain
here...

-- 
Jens Axboe

