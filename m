Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265522AbSJXQMt>; Thu, 24 Oct 2002 12:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265525AbSJXQMt>; Thu, 24 Oct 2002 12:12:49 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:58304 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265522AbSJXQMs>;
	Thu, 24 Oct 2002 12:12:48 -0400
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: landley@trommello.org
Cc: linux-kernel@vger.kernel.org, Erich Focht <efocht@ess.nec.de>
In-Reply-To: <200210231626.12903.landley@trommello.org>
References: <200210231626.12903.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 09:17:10 -0700
Message-Id: <1035476230.1274.1065.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 14:26, Rob Landley wrote:

> 26) NUMA aware scheduler extenstions (Erich Focht, Michael Hohnbaum)
> 
> Home page:
> http://home.arcor.de/efocht/sched/
> 
> Patch:
> http://home.arcor.de/efocht/sched/Nod20_numa_sched-2.5.31.patch

The simple NUMA scheduler patch, which is ready for inclusion is a 
separate project from Erich's NUMA scheduler extensions.  Information
on the simple NUMA scheduler is contained in this lkml posting:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103351680614980&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103480772901235&w=2

The most recent version has been split into two patches for 2.5.44: 

http://marc.theaimsgroup.com/?l=linux-kernel&m=103539626130709&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540481010560&w=2

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

