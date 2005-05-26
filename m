Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVEZEXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVEZEXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 00:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVEZEXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 00:23:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:56038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbVEZEXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 00:23:40 -0400
Date: Wed, 25 May 2005 21:25:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] Changing pci_iounmap to take 'bar' argument
In-Reply-To: <1117080454.9076.25.camel@gaston>
Message-ID: <Pine.LNX.4.58.0505252121290.2307@ppc970.osdl.org>
References: <1117080454.9076.25.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 May 2005, Benjamin Herrenschmidt wrote:
> 
> If it's ok with you, I'll send a patch doing it later today.

It's ok by me, certainly. There aren't that many users, and it sounds
sane. I'll just prefer the patch going through Greg..

		Linus
