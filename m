Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbTI3R3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTI3R3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:29:19 -0400
Received: from village.ehouse.ru ([193.111.92.18]:16389 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261628AbTI3R2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:28:53 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Call traces due to lost IRQ
Date: Tue, 30 Sep 2003 21:28:55 +0400
User-Agent: KMail/1.5.3
References: <20030930154032.GA795@donald.balu5> <slrnbnjcu8.43n.usenet.2117@home.andreas-s.net>
In-Reply-To: <slrnbnjcu8.43n.usenet.2117@home.andreas-s.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309302128.55652.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Tuesday 30 September 2003 20:47, Andreas Schwarz wrote:
> Martin Pitt wrote:
> > [1.] Kernel boot yields lost IRQ with some call traces
> >
> > [2.] When booting 2.6.0-test6, the following message appears:
> >
> > 	------------- snip -------------
> > 	irq 12: nobody cared!
> > 	Call Trace:
> > 	 [<c010b5ca>] __report_bad_irq+0x2a/0x90
> > 	 [<c010b6bc>] note_interrupt+0x6c/0xa0
>
> I've got the same messages (2.6.0-test6-mm1).

I'm so.

