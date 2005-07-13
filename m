Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVGMMce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVGMMce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVGMMce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:32:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:35978 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262825AbVGMMcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:32:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.13-rc3
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jul 2005 14:32:32 +0200
In-Reply-To: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org.suse.lists.linux.kernel>
Message-ID: <p73ackq28f3.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Yes,
>  it's _really_ -rc3 this time, never mind the confusion with the commit 
> message last time (when the Makefile clearly said -rc2, but my over-eager 
> fingers had typed in a commit message saying -rc3).
> 
> There's a bit more changes here than I would like, but I'm putting my foot 
> down now. Not only are a lot of people going to be gone next week for LKS 
> and OLS, but we've gotten enough stuff for 2.6.13, and we need to calm 
> down.


x86-64 is still missing quite a few patches. I'm working on a merge.

-Andi
