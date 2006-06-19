Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWFSOYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWFSOYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWFSOYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:24:00 -0400
Received: from rtr.ca ([64.26.128.89]:27882 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932463AbWFSOYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:24:00 -0400
Message-ID: <4496B37E.2040004@rtr.ca>
Date: Mon, 19 Jun 2006 10:23:58 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Btw, one thing that I was planning to ask people - does anybody find the 
> full-format ChangeLog's that I produce at all useful?

Very useful, thanks.  Without it, we would be shutting out the 99.99%
of the Linux universe who never use Git.

Git is really only used by a handful of core developers -- that's who it
was built for and by.  Sure, there's dozens or even a couple hundred names
in that handful now, but a heck of a lot more people never use git,
and never should have to use git.

Cheers
