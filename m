Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWBOTLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWBOTLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWBOTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:11:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9176 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750934AbWBOTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:11:15 -0500
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
From: Arjan van de Ven <arjan@infradead.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602151059300.14526@dhcp153.mvista.com>
References: <20060215151711.GA31569@elte.hu>
	 <Pine.LNX.4.64.0602151059300.14526@dhcp153.mvista.com>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 20:11:11 +0100
Message-Id: <1140030671.4117.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This patchset provides a new (written from scratch) implementation of
> > robust futexes, called "lightweight robust futexes". We believe this new
> > implementation is faster and simpler than the vma-based robust futex
> > solutions presented before, and we'd like this patchset to be adopted in
> > the upstream kernel. This is version 1 of the patchset.
> 
>  	Next point of discussion must be PI . 

Yes. lets discus PI. Lets discuss it forever so that we'll never get
it ;)


