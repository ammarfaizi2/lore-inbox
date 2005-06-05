Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVFEAOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVFEAOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 20:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVFEAOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 20:14:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:21160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261443AbVFEAOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 20:14:45 -0400
Date: Sat, 4 Jun 2005 17:16:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: git-shortlog script
In-Reply-To: <42A24274.7040906@pobox.com>
Message-ID: <Pine.LNX.4.58.0506041715170.1876@ppc970.osdl.org>
References: <42A22C20.10002@pobox.com> <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
 <42A24274.7040906@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Jun 2005, Jeff Garzik wrote:
> 
> I'm surprised git doesn't fall back to GIT_COMMITTER_NAME if 
> GIT_AUTHOR_NAME doesn't exist, though.

GIT_AUTHOR_NAME existed first ;)

Btw, what does your /etc/passwd look like, and I'll try to hack it up to 
just get that case right by default too..

		Linus
