Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312465AbSDJGTU>; Wed, 10 Apr 2002 02:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312466AbSDJGTT>; Wed, 10 Apr 2002 02:19:19 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28166 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312465AbSDJGTT>; Wed, 10 Apr 2002 02:19:19 -0400
Date: Wed, 10 Apr 2002 02:16:45 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: David Ford <david+cert@blue-labs.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The latest -ac patch to the stable Linux kernels
In-Reply-To: <3CB3C6F5.4020706@blue-labs.org>
Message-ID: <Pine.LNX.3.96.1020410020211.29775A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, David Ford wrote:

> Well, shortly put, the -ac tree is much more -pre than the -pre patches 
> are.  Using -ac patches is jumping ahead of the -pre patches normally.

  At one point Alan posted "I actually run my kernels" and I think that's
important. In some cases they contain perfectly stable features which are
not in the mainline for... I don't want to say "political reasons," but
reasons of policy rather than technical issues. I have run production on
rmap and O(1) for a while, but they seem destined to stay in 2.5 near
term.

  The -ac has the new ServerRAID driver from IBM. Since I have systems
using the hardware which are timezones away, anything which tends to
stability is good in my use. New firmware means new drivers (often) and
the IBM update CD has a binary module only. I'll try the pre5-ac3 instead.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

