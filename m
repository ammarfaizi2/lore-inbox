Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbTBYJpG>; Tue, 25 Feb 2003 04:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267883AbTBYJpG>; Tue, 25 Feb 2003 04:45:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:19340 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267879AbTBYJpF>;
	Tue, 25 Feb 2003 04:45:05 -0500
Date: Tue, 25 Feb 2003 01:55:37 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: 2.5.62-mm3 - no X for me
Message-Id: <20030225015537.4062825b.akpm@digeo.com>
In-Reply-To: <20030225094526.GA18857@gemtek.lt>
References: <20030223230023.365782f3.akpm@digeo.com>
	<3E5A0F8D.4010202@aitel.hist.no>
	<20030224121601.2c998cc5.akpm@digeo.com>
	<20030225094526.GA18857@gemtek.lt>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 09:55:13.0727 (UTC) FILETIME=[FDEDC4F0:01C2DCB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
>
> On Mon, Feb 24, 2003 at 12:16:01PM -0800, Andrew Morton wrote:
> > Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > >
> > > 2.5.62-mm3 boots up fine, but won't run X.  Something goes
> > > wrong switching to graphics so my monitor says "no signal"
> > > 
> >
> This is the boot messages and decoded ksymoops which happens when I try
> to log off and login as a different user in KDE3.1 (debian/unstable).
> 

Ah, thank you.

	kernel BUG at mm/rmap.c:248!

The fickle finger of fate points McCrackenwards.

> > Does 2.5.63 do the same thing?
> I haven't tried this yet.

2.5.63 should be OK.

