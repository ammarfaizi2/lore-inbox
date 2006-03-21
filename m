Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWCUOC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWCUOC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWCUOC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:02:27 -0500
Received: from mail.gmx.de ([213.165.64.20]:31901 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030393AbWCUOC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:02:26 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <200603220045.54736.kernel@kolivas.org>
References: <200603090036.49915.kernel@kolivas.org>
	 <200603220037.52258.kernel@kolivas.org> <20060321134418.GC26171@w.ods.org>
	 <200603220045.54736.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 15:01:30 +0100
Message-Id: <1142949690.7807.80.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 00:45 +1100, Con Kolivas wrote:

> I give up. Add as many tunables as you like in as many places as possible that 
> even less people will understand. You've already told me you'll be running 
> 0,0.

Instead of giving up, how about look at the code and make a suggestion
for improvement?  It's not an easy problem, as you're well aware.

I really don't see why you're (seemingly) getting irate.  Tunables for
this are no different that tunables like CHILD_PENALTY etc etc etc.  How
many casual users know those exist, much less understand them?

	-Mike

