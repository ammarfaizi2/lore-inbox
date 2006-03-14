Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWCNTdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWCNTdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 14:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCNTdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 14:33:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750887AbWCNTdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 14:33:49 -0500
Date: Tue, 14 Mar 2006 11:33:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [git pull] jfs update
In-Reply-To: <20060314184751.C76408318F@kleikamp.dyn.webahead.ibm.com>
Message-ID: <Pine.LNX.4.64.0603141132430.3618@g5.osdl.org>
References: <20060314184751.C76408318F@kleikamp.dyn.webahead.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Mar 2006, Dave Kleikamp wrote:
>
> I'd really like the first of these patches (first in the list, but the most
> recent) to make it into 2.6.16.  All of these patches have been tested in
> -mm, so I'm confident that they won't break anything.  If you don't want to
> pick up all of them, I could send you just the one patch.

At this point in the game, I'd rather take just individual patches known 
to fix particular bugs..

It's ok if the patches come in through a git tree, but the particular git 
tree you pointed to has other diffs that definitely look like fine 
cleanups, but still they're just cleanups.

		Linus
