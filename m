Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753125AbVHGXxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbVHGXxV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbVHGXxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:53:21 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:6615 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752860AbVHGXxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:53:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Date: Mon, 8 Aug 2005 09:51:25 +1000
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
References: <200508031559.24704.kernel@kolivas.org> <200508071512.22668.kernel@kolivas.org> <20050807165833.GA13918@in.ibm.com>
In-Reply-To: <20050807165833.GA13918@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508080951.26433.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005 02:58, Srivatsa Vaddagiri wrote:
> On Sun, Aug 07, 2005 at 03:12:21PM +1000, Con Kolivas wrote:
> > Respin of the dynamic ticks patch for i386 by Tony Lindgen and Tuukka
> > Tikkanen with further code cleanups. Are were there yet?
>
> Con,
> 	I am afraid until SMP correctness is resolved, then this is not
> in a position to go in (unless you want to enable it only for UP, which
> I think should not be our target). I am working on making this work
> correctly on SMP systems. Hopefully I will post a patch soon.

> Will keep you posted of my progress with dynamic tick patch.

Great! I wasn't sure what time frame you meant when you last posted. I won't 
do anything more, leaving this patch as it is, and pass the baton to you.

Cheers,
Con
