Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbTCPHTw>; Sun, 16 Mar 2003 02:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTCPHTw>; Sun, 16 Mar 2003 02:19:52 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:49286 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S262484AbTCPHTw>; Sun, 16 Mar 2003 02:19:52 -0500
Date: Sat, 15 Mar 2003 23:30:41 -0800
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.5.64-mjb4 (scalability / NUMA patchset)
Message-ID: <20030316073041.GA10721@gnuppy.monkey.org>
References: <169550000.1046895443@[10.10.2.4]> <475260000.1047172886@[10.10.2.4]> <85960000.1047532556@[10.10.2.4]> <10770000.1047787269@[10.10.2.4]> <20030316044524.GA6757@gnuppy.monkey.org> <12150000.1047793549@[10.10.2.4]> <20030316063151.GA7114@gnuppy.monkey.org> <19840000.1047797300@[10.10.2.4]> <20030316065650.GA8164@gnuppy.monkey.org> <20280000.1047798483@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20280000.1047798483@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 11:08:04PM -0800, Martin J. Bligh wrote:
> What happens if you turn this bit off ?
> CONFIG_DEBUG_SLAB=y
> 
> Did you do "yes | make oldconfig" at some point? ;-)

eh ? I'm kind of build system stupid. Trying it again with that
CONFIG_ option turned off.

Yeah, it got past that point now.

bill

