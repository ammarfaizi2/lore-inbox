Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVFPLoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVFPLoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 07:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVFPLoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 07:44:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50870 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261576AbVFPLoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 07:44:05 -0400
Date: Thu, 16 Jun 2005 13:44:02 +0200
From: Martin Mares <mj@ucw.cz>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Hannu Savolainen <hannu@opensound.com>,
       Matthias Urlichs <matthias@urlichs.de>,
       Nick Holloway <Nick.Holloway@pyrites.org.uk>,
       Hans Lermen <lermen@elserv.ffm.fgan.de>,
       Werner Almesberger <werner@almesberger.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] trivial warning fix and whitespace cleanup for arch/i386/boot/compressed/misc.c
Message-ID: <20050616114402.GG14042@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0506160002020.3842@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506160002020.3842@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's a trivial patch to fix two tiny gcc -W warnings:

Fine with me. You can also remove the surplus (char *) casts.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
VI has two modes: the one in which it beeps and the one in which it doesn't.
