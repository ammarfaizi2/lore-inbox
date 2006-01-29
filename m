Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWA2OmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWA2OmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 09:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWA2OmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 09:42:13 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:20412 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1751012AbWA2OmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 09:42:12 -0500
Date: Sun, 29 Jan 2006 15:42:34 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060129144233.GA3052@dreamland.darkstar.lan>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan> <20060127232207.GB1617@elf.ucw.cz> <20060128155800.GA3064@dreamland.darkstar.lan> <20060128163611.GB1858@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128163611.GB1858@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Jan 28, 2006 at 05:36:11PM +0100, Pavel Machek ha scritto: 
> > > If vbetool's primary purpose is to fix video after suspend/resume,
> > > then perhaps right thing to do is to integrate it into s2ram and
> > > maintain it there.
> > > 
> > > Matthew, what do you think?
> > > 
> > > Luca, would you cook quick&hacky fork-and-exec patch? I do not have
> > > machine that needs vbetool...
> > 
> > Very quick and very hacky ;)
> 
> Thanks; applied after some cleanups. Could you fetch it from cvs and
> confirm it still works?

Yup, it's ok.

Luca
-- 
Home: http://kronoz.cjb.net
The trouble with computers is that they do what you tell them, 
not what you want.
D. Cohen
