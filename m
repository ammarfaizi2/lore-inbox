Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbUKJByq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUKJByq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbUKJBxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:53:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:33260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261819AbUKJBwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:52:03 -0500
Date: Tue, 9 Nov 2004 17:51:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] Use -ffreestanding?
In-Reply-To: <20041110014516.GC4089@stusta.de>
Message-ID: <Pine.LNX.4.58.0411091750480.2301@ppc970.osdl.org>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de>
 <20041108153436.GB9783@stusta.de> <20041108161935.GC2456@wotan.suse.de>
 <20041108163101.GA13234@stusta.de> <20041108175120.GB27525@wotan.suse.de>
 <20041108183449.GC15077@stusta.de> <20041108190130.GA2564@wotan.suse.de>
 <20041108233806.GM15077@stusta.de> <20041109050107.GA5328@wotan.suse.de>
 <20041110014516.GC4089@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Nov 2004, Adrian Bunk wrote:
> 
> I'm open for examples why this actually doesn't work, but after my 
> (limited) testin I'd suggest the patch below for inclusion in the next 
> -mm.

When was -ffreestanding introduced? Iow, it might not work with all 
compiler versions.. Apart from that, I think it makes sense. 

		Linus
