Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270303AbTGMRII (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270306AbTGMRII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:08:08 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:8070 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270303AbTGMRIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:08:07 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 10:15:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <20030713141121.GG19132@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307131013510.14680@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
 <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
 <20030712162029.GE9547@mail.jlokier.co.uk> <1058028064.1196.111.camel@mf>
 <20030712185157.GC10450@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307121806560.4720@bigblue.dev.mcafeelabs.com>
 <20030713141121.GG19132@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > You need per-user policies to achieve fairness, the global allocation
> > won't work.
>
> Agreed that fairness is complicated.  However, a global limit is
> needed because it's a big security hole to not have one.  I wonder if
> a global limit can't be implemented very simply?

Yes, it is farily/very simple. I'll write it down today ...



- Davide

