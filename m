Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTENRb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTENRb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:31:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:1123 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263310AbTENRat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:30:49 -0400
Date: Wed, 14 May 2003 10:44:55 -0700
From: Andrew Morton <akpm@digeo.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v3
Message-Id: <20030514104455.374b5df6.akpm@digeo.com>
In-Reply-To: <20030514171000.GB23380@waste.org>
References: <20030514032712.0c7fa0d1.akpm@digeo.com>
	<20030514171000.GB23380@waste.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 17:43:32.0550 (UTC) FILETIME=[565A6660:01C31A40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> On Wed, May 14, 2003 at 03:27:12AM -0700, Andrew Morton wrote:
> > 
> > Quite a lot of changes here.  Mostly additions, but some things have been
> > crossed off.
> 
> Has handling of async write errors fallen off your radar? Should I
> start pushing that again?
> 

No, I haven't forgotten.  If you want to rediff the patches sometime that'd
be appreciated, thanks.
