Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTESXYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTESXYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:24:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263310AbTESXYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:24:51 -0400
Date: Mon, 19 May 2003 16:33:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.6 must-fix, v4
Message-Id: <20030519163306.4237dab5.rddunlap@osdl.org>
In-Reply-To: <20030516161753.08470617.akpm@digeo.com>
References: <20030516161717.1e629364.akpm@digeo.com>
	<20030516161753.08470617.akpm@digeo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 May 2003 16:17:53 -0700 Andrew Morton <akpm@digeo.com> wrote:

| fs/
| ---
| 
| - Integrate Chris Mason's 2.4 reiserfs ordered data and data journaling
|   patches.  They make reiserfs a lot safer.

What's the delay on this?  I used this code last June/July,
and I understand that SuSE has been shipping it for awhile now.

--
~Randy
