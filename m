Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWEVD0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWEVD0d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWEVD0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:26:32 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:4045 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965002AbWEVD0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:26:32 -0400
Message-ID: <44712F65.2070704@bigpond.net.au>
Date: Mon, 22 May 2006 13:26:29 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>, Rene Herman <rene.herman@keyaccess.nl>,
       Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
References: <4470CC8F.9030706@keyaccess.nl> <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer> <200605221243.54100.kernel@kolivas.org>
In-Reply-To: <200605221243.54100.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 22 May 2006 03:26:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Monday 22 May 2006 12:14, Mike Galbraith wrote:
>> In my tree, I don't use the expired array for anything except batch
>> tasks any more for this very reason. The latency just hurts too bad.
> 
> So it's turning your tree into a single priority array design effectively just 
> like staircase ;) ?
> 

And the various SPA schedulers in plugsched. ;-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
