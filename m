Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTEWIfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTEWIfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:35:47 -0400
Received: from tmi.comex.ru ([217.10.33.92]:28866 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263944AbTEWIfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:35:46 -0400
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Fri, 23 May 2003 12:49:26 +0000
In-Reply-To: <20030523014934.37a1c10d.akpm@digeo.com> (Andrew Morton's
 message of "Fri, 23 May 2003 01:49:34 -0700")
Message-ID: <87smr5vne1.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
	<87addhd2mc.fsf@gw.home.net> <20030521093848.59ada625.akpm@digeo.com>
	<87smr8c9le.fsf@gw.home.net> <20030521095921.4f457002.akpm@digeo.com>
	<m3brxwe2lr.fsf@lexa.home.net>
	<20030521103737.52eddeb3.akpm@digeo.com> <87n0hgc6s6.fsf@gw.home.net>
	<20030521105011.2d316baf.akpm@digeo.com> <87k7ckc5z2.fsf@gw.home.net>
	<20030521143140.3aaa86ba.akpm@digeo.com> <8765o1x6mb.fsf@gw.home.net>
	<20030523014934.37a1c10d.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> The balloc.c code is getting awfully convoluted and hard to follow,
 AM> but no obvious restructuring strategies are leaping out at me.

agree. I'll try to figure out something more readable sometime


