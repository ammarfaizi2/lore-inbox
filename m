Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbUKOXxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUKOXxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUKOXxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:53:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:40390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261655AbUKOXtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:49:09 -0500
Date: Mon, 15 Nov 2004 15:53:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-Id: <20041115155311.64ae2150.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0411151821050.3265@blysk.ds.pg.gda.pl>
References: <41967669.3070707@aknet.ru>
	<Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl>
	<4198EFE5.5010003@aknet.ru>
	<Pine.LNX.4.58L.0411151821050.3265@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>
>  And btw, dmesg is still silent about a
> > LAPIC. This makes me nervous when I am
> > trying to figure out whether it works or
> > not:) Would be nice to get those prominent
> > messages back, as per 2.6.8.
> 
>  Someone wasn't as much fond of them as you are and they were removed by
> default.  I'm pissed off, too

Don't be pissed off - please send a patch which puts in whatever debugging
you think we need to have to be able to properly support the APIC code.

Stuff happens.
