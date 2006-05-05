Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751734AbWEET7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWEET7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWEET7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 15:59:36 -0400
Received: from leitseite.net ([213.239.214.51]:49289 "EHLO mail.leitseite.net")
	by vger.kernel.org with ESMTP id S1751711AbWEET7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 15:59:36 -0400
Date: Fri, 5 May 2006 21:59:11 +0200 (CEST)
From: Nuri Jawad <lkml@jawad.org>
X-X-Sender: lkml@pc
To: Dave Jones <davej@redhat.com>
Cc: Martin Mares <mj@ucw.cz>, Pavel Machek <pavel@ucw.cz>,
       dtor_core@ameritech.net, "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
In-Reply-To: <20060505160009.GB25883@redhat.com>
Message-ID: <Pine.LNX.4.64.0605052131580.28721@pc>
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz>
 <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com>
 <20060504183840.GE18962@redhat.com> <20060505103123.GB4206@elf.ucw.cz>
 <20060505152748.GA22870@redhat.com> <mj+md-20060505.153608.7268.albireo@ucw.cz>
 <20060505154638.GE22870@redhat.com> <mj+md-20060505.154834.7444.albireo@ucw.cz>
 <20060505160009.GB25883@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2006, Dave Jones wrote:

> Did you read my earlier posts?

Sorry to interrupt, but did you read my reply?

> How on earth is "too many keys pressed" a useful message in this context?

It doesn't say "user pressed too many keys", it says the keyboard *reports 
too many keys pressed* which is most likely what's happening. This is not 
a terribly useful, but valid error message.

> Yes, maybe their keyboard is crap, but what is the user to do?

Nothing, take notice of the fact.

> Go buy a new laptop because someone else has a utopian view on how 
> hardware should be?

You mean deciding not to silently ignore errors is having a utopian view? 
Are we talking about Linux or kernel32.dll?

> When a user can't do *anything* about it, it's useless, and serves
> as nothing but a cause for concern. "Oh no, is my laptop dying?".

Laptops come with Windows XP pre-installed for those users, what was your 
problem again?

Regards, Nuri
