Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWAGBIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWAGBIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWAGBIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:08:06 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:9650 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932639AbWAGBIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:08:05 -0500
Date: Sat, 7 Jan 2006 02:07:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, arjan@infradead.org,
       nico@cam.org, jes@trained-monkey.org, viro@ftp.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       hch@infradead.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 17/21] mutex subsystem, semaphore to mutex: automatic conversion of simpler cases
Message-ID: <20060107010749.GA6267@elte.hu>
References: <20060105153903.GR31013@elte.hu> <20060106170146.7e19a968.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106170146.7e19a968.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> I think I'll duck this one for now.
> 
> Perhaps it should be split up a bit?

yeah, i'll merge it tomorrow and will split it up into per-driver 
patches. Could you upload an x.bz2 i should merge against - or is 
Linus-curr OK?

	Ingo
