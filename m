Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUDOKVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUDOKVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:21:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4011 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261443AbUDOKVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:21:44 -0400
Subject: Re: [SECURITY] CAN-2004-0177 (was: Re: [SECURITY] CAN-2004-0075)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200404150135.03714@WOLK>
References: <20040414171147.GB23419@redhat.com> <200404142230.33553@WOLK>
	 <200404150135.03714@WOLK>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1082024495.2100.41.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2004 11:21:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-04-15 at 00:35, Marc-Christian Petersen wrote:

> > Okay, now while we are at fixing security holes, is there any chance we
> > can get the attached patch in?
> 
> Okay, we are at it, so what's about the attached one too? ;)
> 
> In WOLK for some time too. I am not 100% sure if this is correct, but I think 
> it is. Andrew? Stephen?

Looks OK to me.  I'll see if I can detect any performance cost from it,
but it's unlikely to be significant even if it's measurable.

--Stephen

