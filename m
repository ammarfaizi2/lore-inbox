Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTEOAYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTEOAYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:24:20 -0400
Received: from durham-24-086.biz.dsl.gtei.net ([4.3.24.86]:16020 "EHLO
	amanda.mallet-assembly.org") by vger.kernel.org with ESMTP
	id S263201AbTEOAYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:24:19 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
	<buou1bz7h9a.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<Pine.LNX.4.44.0305131710280.5042-100000@serv>
	<20030513211749.GA340@gnu.org>
	<Pine.LNX.4.44.0305142014500.5042-100000@serv>
	<jellx9b62v.fsf@sykes.suse.de>
	<Pine.LNX.4.44.0305142358590.5042-100000@serv>
From: Michael Alan Dorman <mdorman@debian.org>
Date: Wed, 14 May 2003 20:21:19 -0400
In-Reply-To: <Pine.LNX.4.44.0305142358590.5042-100000@serv> (Roman Zippel's
 message of "Thu, 15 May 2003 00:11:39 +0200 (CEST)")
Message-ID: <87issddpq8.fsf@amanda.mallet-assembly.org>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:
> Hmm, I think it doesn't really fit, it's a bit more than this, e.g. if one 
> option is set 'm', the other option can still be set to 'm' or 'y'. The 
> logic is basically "if this option is selected, automatically select this 
> other option too.", so currently I like "select" best.

How about 'assert'?

Mike
-- 
I don't need no makeup, I've got real scars -- Tom Waits
