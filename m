Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270672AbTHCCDP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 22:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270818AbTHCCDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 22:03:15 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:35590 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270672AbTHCCDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 22:03:13 -0400
Subject: Re: 2.6.0-test2-mm3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030802190055.5e600c20.akpm@osdl.org>
References: <20030802152202.7d5a6ad1.akpm@osdl.org>
	 <1059875394.618.0.camel@teapot.felipe-alfaro.com>
	 <20030802190055.5e600c20.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1059876190.618.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 03 Aug 2003 04:03:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-03 at 04:00, Andrew Morton wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > On Sun, 2003-08-03 at 00:22, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm3/
> > > 
> > > . Con's CPU scheduler rework has been dropped out and Ingo's changes have
> > >   been added.
> > 
> > Why?
> 
> Because of the other reasons which I mentioned?  We need additional
> infrastructure such as the nanosecond timing to do this right.

That's what happens when one doesn't read carefully an e-mail message.
Thanks, Andrew...

