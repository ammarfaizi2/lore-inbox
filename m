Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbVBDP45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbVBDP45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 10:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbVBDP45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 10:56:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:35301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264323AbVBDP4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 10:56:52 -0500
Date: Fri, 4 Feb 2005 07:56:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gerd Knorr <kraxel@bytesex.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] tv-card tuner fixup
In-Reply-To: <20050204130102.GA24220@bytesex>
Message-ID: <Pine.LNX.4.58.0502040756120.2165@ppc970.osdl.org>
References: <20050204130102.GA24220@bytesex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Feb 2005, Gerd Knorr wrote:
> 
> That one should go into 2.6.11.
> 
> - fix initialization order bug.

I applied your earlier patch already. Can you verify that I merged 
everything correctly, and that my current BK tree matches yours?

		Linus
