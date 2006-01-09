Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWAIGN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWAIGN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWAIGN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:13:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751043AbWAIGNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:13:55 -0500
Date: Sun, 8 Jan 2006 22:13:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
cc: "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
In-Reply-To: <46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0601082212420.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
 <46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2006, Martin Langhoff wrote:
> 
> and if it does anything but a very trivial merge, backtrack and do a merge.

To be fair, backtracking a "git-rebase" isn't obvious. One of the 
downsides of rebasing.

		Linus
