Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269751AbUICSqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269751AbUICSqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269734AbUICSml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:42:41 -0400
Received: from imap.gmx.net ([213.165.64.20]:19656 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269747AbUICSlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:41:47 -0400
X-Authenticated: #4399952
Date: Fri, 3 Sep 2004 20:54:15 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: lockup with voluntary preempt R0 and VP, KP, etc, disabled
Message-ID: <20040903205415.0a3cdc23@mango.fruits.de>
In-Reply-To: <1094236105.6575.16.camel@krustophenia.net>
References: <20040903120957.00665413@mango.fruits.de>
	<20040903100946.GA22819@elte.hu>
	<20040903123139.565c806b@mango.fruits.de>
	<20040903103244.GB23726@elte.hu>
	<20040903135919.719db41d@mango.fruits.de>
	<20040903140425.26fddf8e@mango.fruits.de>
	<20040903140811.37ae8067@mango.fruits.de>
	<1094236105.6575.16.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2004 14:28:26 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> Change EXTRAVERSION in the top level kernel Makefile.  The newer VP
> patches do this for you.

Ok, though my incentive was to have different versions of the same VP
patched kernel [different config stuff though] ready w/o rebuilding in
between.

Thanks for the tip :)

flo
