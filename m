Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTE0VGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbTE0VGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:06:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35228 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264186AbTE0VGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:06:25 -0400
Date: Tue, 27 May 2003 23:19:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527211940.GC845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305272253.06726.m.c.p@wolk-project.de> <20030527210019.GA845@suse.de> <200305272310.44657.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272310.44657.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27 2003, Marc-Christian Petersen wrote:
> On Tuesday 27 May 2003 23:00, Jens Axboe wrote:
> 
> Hi Jens,
> 
> > Are you serious? Please tell me you haven't spend two weeks on the
> > project not realising this?
> Well, 2 weeks means in hours not more than 5 or 6 just delayed over many days.
> 
> And it was further just to go deeper into the code, not a real attempt to 
> backport it. NM.

A bigger analysis of the problem before starting mindless (and useless)
porting would have brought you a lot farther :)

If you're just looking to port some io schedulers, the explanation I
left you in the previous mail should be plenty to get you started.

-- 
Jens Axboe

