Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbSJJDmn>; Wed, 9 Oct 2002 23:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSJJDmn>; Wed, 9 Oct 2002 23:42:43 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:13841 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S263193AbSJJDmm>; Wed, 9 Oct 2002 23:42:42 -0400
Date: Wed, 9 Oct 2002 20:48:22 -0700
From: jw schultz <jw@pegasys.ws>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: rsync kernel tree Re: New BK License Problem?
Message-ID: <20021010034822.GA15333@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0210062308290.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210062308290.22735-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 11:10:48PM -0300, Rik van Riel wrote:
> People can grab the repository for use with CSSC from:
> 
> 	ftp://nl.linux.org/pub/linux/bk2patch/
> 
> Or using rsync:
> 	rsync -rav --delete nl.linux.org::kernel/linux-2.4 linux-2.4
> 	rsync -rav --delete nl.linux.org::kernel/linux-2.5 linux-2.5
> 
> Currently these repositories are updated every two hours, but if
> there is a large demand I could update it every hour or even every
> 30 minutes.  Don't feel ashamed to put the above rsyncs into your
> crontabs, grab the source and use it ;)
> 
> have fun,

I just might.  Although a straight tree (instead of
repository) would suit me better.

Like many i haven't been folowing the BK license thread.  I
only found out about this message because of a kernel trap
headline.  Rik you might get a better exposure if you
announced this outside of the BK license thread.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
