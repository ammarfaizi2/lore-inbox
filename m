Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbTGLQMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbTGLQMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:12:17 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:62598 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266114AbTGLQLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:11:21 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 09:18:35 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <20030712162029.GE9547@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307120915250.4351@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
 <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
 <20030712162029.GE9547@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Jamie Lokier wrote:

> I'm wondering what happens if the tasks are both good, early to bed
> without a fuss.  Neither runs their entire timeslice.
>
> Or to illustrate: say xine uses 10% of my CPU.  What happens when I
> open 11 xine windows?

You need an adaptor ... hmmm ... another CPU :)
(if this is case, it is a trivial fix though)



- Davide

