Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTBFH7C>; Thu, 6 Feb 2003 02:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTBFH7C>; Thu, 6 Feb 2003 02:59:02 -0500
Received: from mail020.syd.optusnet.com.au ([210.49.20.135]:22989 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S265711AbTBFH7C>; Thu, 6 Feb 2003 02:59:02 -0500
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.59-mm8 with contest
Date: Thu, 6 Feb 2003 19:08:32 +1100
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200302052221.55663.conman@kolivas.net> <3E417624.2762A635@digeo.com>
In-Reply-To: <3E417624.2762A635@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302061908.32848.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003 07:37 am, Andrew Morton wrote:
> Con Kolivas wrote:
> > ..
> >
> > This seems to be creeping up to the same as 2.5.59
> > ...
> > and this seems to be taking significantly longer
> > ...
> > And this load which normally changes little has significantly different
> > results.
>
> There were no I/O scheduler changes between -mm7 and -mm8.  I
> demand a recount!

Repeated mm7 and mm8. 
Recount-One for Martin, two for Martin. Same results; not the i/o scheduler 
responsible for the changes, but I have a sneaking suspicion another 
scheduler may be.

Con
