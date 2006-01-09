Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932907AbWAIGqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbWAIGqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWAIGqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:46:12 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56733 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932907AbWAIGqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:46:09 -0500
From: Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
	<46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
	<Pine.LNX.4.64.0601082212420.3169@g5.osdl.org>
Date: Sun, 08 Jan 2006 22:46:06 -0800
In-Reply-To: <Pine.LNX.4.64.0601082212420.3169@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 8 Jan 2006 22:13:49 -0800 (PST)")
Message-ID: <7vlkxpucep.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> To be fair, backtracking a "git-rebase" isn't obvious. One of the 
> downsides of rebasing.

I thought "git reset --hard ORIG_HEAD" as usual would do.

