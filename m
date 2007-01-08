Return-Path: <linux-kernel-owner+w=401wt.eu-S965286AbXAHBMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbXAHBMs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbXAHBMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:12:48 -0500
Received: from smtp.osdl.org ([65.172.181.24]:32812 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965286AbXAHBMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:12:47 -0500
Date: Sun, 7 Jan 2007 17:09:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
cc: Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc3: known unfixed regressions - x86_64 boot failure:
 "IO-APIC + timer doesn't work"
In-Reply-To: <20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
Message-ID: <Pine.LNX.4.64.0701071708240.3661@woody.osdl.org>
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com>
 <86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
 <20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2007, Tobias Diedrich wrote:
>
> Yinghai Lu wrote:
> > Please check the latest version. ( 01/02/2007)
> 
> Works for me, with both BIOS versions / routing variants.

Yinghai, Eric, can you please send me the latest version with 
 (a) explanations for the changelogs
 (b) sign-off's (and acks for Eric, please) on it..

Let's get this one off the table.

		Linus
