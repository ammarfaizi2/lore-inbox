Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSJGCYS>; Sun, 6 Oct 2002 22:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSJGCYR>; Sun, 6 Oct 2002 22:24:17 -0400
Received: from bitmover.com ([192.132.92.2]:32149 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262446AbSJGCYR>;
	Sun, 6 Oct 2002 22:24:17 -0400
Date: Sun, 6 Oct 2002 19:29:50 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ben Collins <bcollins@debian.org>, Nicolas Pitre <nico@cam.org>,
       Ulrich Drepper <drepper@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
Message-ID: <20021006192950.A3649@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Ben Collins <bcollins@debian.org>, Nicolas Pitre <nico@cam.org>,
	Ulrich Drepper <drepper@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20021007020139.GY566@phunnypharm.org> <Pine.LNX.4.44L.0210062308290.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0210062308290.22735-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sun, Oct 06, 2002 at 11:10:48PM -0300
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> People can grab the repository for use with CSSC from:
> 
> 	ftp://nl.linux.org/pub/linux/bk2patch/

Make sure you do a

	bk -r admin -Znone

on that tree.  We support gzipped repos, SCCS/CSSC don't.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
