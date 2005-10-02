Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVJBKc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVJBKc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 06:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVJBKc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 06:32:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8519
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751065AbVJBKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 06:32:56 -0400
Date: Sun, 2 Oct 2005 12:32:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
Message-ID: <20051002103255.GD26677@opteron.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu> <20050923153158.GA4548@x30.random> <1127509047.8880.4.camel@kleikamp.austin.ibm.com> <1127509155.8875.6.camel@kleikamp.austin.ibm.com> <1127511979.8875.11.camel@kleikamp.austin.ibm.com> <20050928223829.GH10408@opteron.random> <1128126424.10237.7.camel@kleikamp.austin.ibm.com> <20051002102726.GB26677@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002102726.GB26677@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 12:27:26PM +0200, Andrea Arcangeli wrote:
> Note Valids, your smtp server bounces back my emails.

here we go again:

<Valdis.Kletnieks@vt.edu>: host smtp.vt.edu[198.82.161.8] said: 550 This domain
    is blacklisted,consult your postmaster (in reply to MAIL FROM command)

If you blacklist 0.0.0.0/0 as well you won't risk getting any more spam ;)
