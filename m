Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752639AbWAHR5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbWAHR5c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbWAHR5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:57:32 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11980 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1752639AbWAHR5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:57:32 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Roger Luethi <rl@hellgate.ch>
Subject: Re: [PATCH] 2.6.15: via-rhine + link loss + autoneg off == trouble
Date: Sun, 8 Jan 2006 19:57:14 +0200
User-Agent: KMail/1.8.2
Cc: Lee Revell <rlrevell@joe-job.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
References: <200601071820.16092.vda@ilport.com.ua> <1136659670.8750.14.camel@mindpipe> <20060107210417.GA32681@k3.hellgate.ch>
In-Reply-To: <20060107210417.GA32681@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081957.14136.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 23:04, Roger Luethi wrote:
> On Sat, 07 Jan 2006 13:47:50 -0500, Lee Revell wrote:
> > On Sat, 2006-01-07 at 18:20 +0200, Denis Vlasenko wrote:
> > > Hi,
> > > 
> > > 2.6.15 still exhibits the via rhine "no tx" syndrome.
> > 
> > Well you didn't cc: the via-rhine maintainer (Roger Luethi), no wonder
> > the patch didn't get picked up...
 
> As long as you mention via-rhine, I am going to see it (thanks, procmail).
> I don't remember seeing vda post a patch before. First he posted a problem
> description, then an analysis (that I commented on), now a patch. Finally,

It's my second patch for this (really trivial) problem.
--
vda
