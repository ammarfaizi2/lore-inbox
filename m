Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752378AbWCKIVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbWCKIVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbWCKIVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:21:40 -0500
Received: from mail.gmx.de ([213.165.64.20]:9703 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752378AbWCKIVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:21:40 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
From: Mike Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <44128747.8060800@yahoo.com.au>
References: <200603102054.20077.kernel@kolivas.org>
	 <1142056851.7819.54.camel@homer> <1142057114.7819.57.camel@homer>
	 <200603111820.35780.kernel@kolivas.org> <1142063055.7605.6.camel@homer>
	 <44128747.8060800@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 09:22:37 +0100
Message-Id: <1142065357.7978.2.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 19:16 +1100, Nick Piggin wrote:
> Mike Galbraith wrote:
> > On Sat, 2006-03-11 at 18:20 +1100, Con Kolivas wrote:
> >>On Saturday 11 March 2006 17:05, Mike Galbraith wrote:
> >>>On Sat, 2006-03-11 at 07:00 +0100, Mike Galbraith wrote:
> >>>>On Sat, 2006-03-11 at 16:50 +1100, Con Kolivas wrote:
> >>>>>On Saturday 11 March 2006 16:33, Mike Galbraith wrote:
> >>>>>>On Sat, 2006-03-11 at 14:50 +1100, Con Kolivas wrote:
> >>>>>>>On Saturday 11 March 2006 09:35, Andrew Morton wrote:
> >>>>>>>>Con Kolivas <kernel@kolivas.org> wrote:
> 
> So... you guys ever think about trimming this? Not only would
> it be faster to read, you can save the list server about 15MB
> worth of email a pop with just a small haircut.
> 

Sorry, was doing too many things at once to notice.  I think we're about
done yacking anyway.

	-Mike

