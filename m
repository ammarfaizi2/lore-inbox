Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269800AbUJVHds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269800AbUJVHds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269760AbUJVHcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:32:48 -0400
Received: from mail.dif.dk ([193.138.115.101]:30391 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269839AbUJSQsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:48:04 -0400
Date: Tue, 19 Oct 2004 18:55:59 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: ebiederm@xmission.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9...
In-Reply-To: <m13c0bto1o.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0410191852420.2932@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
 <m13c0bto1o.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2004 ebiederm@xmission.com wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Ok,
> >  despite some naming confusion (expanation: I'm a retard), I did end up
> > doing the 2.6.9 release today. And it wasn't the same as the "-final" test
> > release (see explanation above).
> > 
> > Excuses aside, not a lot of changes since -rc4 (which was the last
> > announced test-kernel), mainly some UML updates that don't affect anybody
> > else. And a number of one-liners or compiler fixes. Full list appended.
> 
> The ChangeLog-2.6.9 only list changes from v2.6.9-rc4 and not 2.6.8
> 
> ChangeLogs that don't cover the same set of changes their corresponding
> patches cover just don't seem right somehow.
> 
I agree, that was bugging me as well. Having the full ChangeLog to the 
previous version in kernel.org/pub/linux/kernel/v2.6/ is useful, having 
only a partial log is less so.
Could we please get the complete 2.6.8 -> 2.6.9 ChangeLog there?


--
Jesper Juhl

