Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266428AbTGJRvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266415AbTGJRvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:51:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1253 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S269579AbTGJRtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:49:41 -0400
Date: Thu, 10 Jul 2003 15:01:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Peter Lojkin <ia6432@inbox.ru>, green@namesys.com,
       Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
In-Reply-To: <20030710191254.093354d2.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0307101458490.25229@freak.distro.conectiva>
References: <E19ae9K-000Nas-00.ia6432-inbox-ru@f7.mail.ru>
 <20030710191254.093354d2.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Jul 2003, Stephan von Krawczynski wrote:

> On Thu, 10 Jul 2003 20:20:02 +0400
> "Peter Lojkin" <ia6432@inbox.ru> wrote:
>
> > Hello,
> >
> > here is exact patch i've used. i made it by cutting pre2-pre3 diff,
> > so apply it o top of 2.4.22-pre3 with -R option to patch...
>
> Hello Peter
> Hello Marcelo
>
> I can confirm that pre3 works when reversing the attached patch. Thanks very
> much, Peter.

Fine Stephan. Now can youplease get us the task backtraces from sysrq when
the hang happens?

Andrea, Chris, any idea of why this is happening?


