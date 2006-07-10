Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161285AbWGJBWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbWGJBWq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 21:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWGJBWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 21:22:46 -0400
Received: from mail.suse.de ([195.135.220.2]:16831 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964976AbWGJBWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 21:22:46 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
Date: Mon, 10 Jul 2006 02:08:25 +0200
User-Agent: KMail/1.9.3
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, gregoire.favre@gmail.com,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <20060709021106.9310d4d1.akpm@osdl.org> <200607100037.14958.rjw@sisk.pl> <20060709154445.60d6619c.akpm@osdl.org>
In-Reply-To: <20060709154445.60d6619c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100208.25520.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Like this:
> > 
> >  arch/x86_64/kernel/vsyscall.c |    6 ++++++
> >  1 files changed, 6 insertions(+)

Sorry will do a proper patch.

-Andi
