Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945988AbWKJGrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945988AbWKJGrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945989AbWKJGrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:47:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945988AbWKJGrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:47:24 -0500
Date: Thu, 9 Nov 2006 22:43:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jeff Chua" <jeff.chua.linux@gmail.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Matthew Wilcox" <matthew@wil.cx>, "Andi Kleen" <ak@suse.de>,
       "Aaron Durbin" <adurbin@google.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
Message-Id: <20061109224356.729716fe.akpm@osdl.org>
In-Reply-To: <b6a2187b0611092225m47378626oe62b0466d904abbd@mail.gmail.com>
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>
	<20061107171143.GU27140@parisc-linux.org>
	<200611080839.46670.ak@suse.de>
	<20061108122237.GF27140@parisc-linux.org>
	<Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
	<20061108172650.GC4729@stusta.de>
	<Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
	<Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
	<Pine.LNX.4.64.0611081010120.3667@g5.osdl.org>
	<b6a2187b0611092225m47378626oe62b0466d904abbd@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 14:25:30 +0800
"Jeff Chua" <jeff.chua.linux@gmail.com> wrote:

> On 11/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Pushed out. Jeff, can you verify that current git does the right thing.
> 
> Linus,
> 
> Can you post those affected patches that I can apply directly to 2.6.19-rc5?

http://userweb.kernel.org/~akpm/origin.patch is Linus's tree as of twenty seconds
ago (against 2.6.19-rc5)
