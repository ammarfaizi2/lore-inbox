Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbVLWIE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbVLWIE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 03:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbVLWIE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 03:04:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43402 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030455AbVLWIE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 03:04:26 -0500
Date: Fri, 23 Dec 2005 09:04:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [patch 0/8] mutex subsystem, -V6
Message-ID: <20051223080402.GA9614@elte.hu>
References: <20051222230438.GA13302@elte.hu> <Pine.LNX.4.64.0512222355130.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512222355130.26663@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> On Fri, 23 Dec 2005, Ingo Molnar wrote:
> 
> > this is verion -V6 of the generic mutex subsystem.
> 
> Here's a patch to fix a few minor things: some comments were wrong, 
> some were irrelevant, another was duplicated.  Also remove a bogus 
> "return 0".

thanks, merged.

	Ingo
