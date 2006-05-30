Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWE3UlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWE3UlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWE3UlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:41:15 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:26341 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932408AbWE3UlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:41:14 -0400
Date: Tue, 30 May 2006 22:41:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <rdreier@cisco.com>
Cc: Dave Jones <davej@redhat.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       nanhai.zou@intel.com
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530204123.GA27436@elte.hu>
References: <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com> <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com> <1148967947.3636.4.camel@laptopd505.fenrus.org> <20060530141006.GG14721@redhat.com> <1148998762.3636.65.camel@laptopd505.fenrus.org> <20060530145852.GA6566@redhat.com> <20060530171118.GA30909@dominikbrodowski.de> <20060530190235.GC17218@redhat.com> <adafyir71sm.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adafyir71sm.fsf@cisco.com>
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


* Roland Dreier <rdreier@cisco.com> wrote:

>     Dave> I was hoping you could enlighten me :) I started picking
>     Dave> through history with gitk, but my tk install uses fonts that
>     Dave> make my eyes bleed.  My kingdom for a 'git annotate'..
> 
> Heh -- try "git annotate" or "git blame".  I think you need git 1.3.x 
> for that... details of where to send your kingdom forthcoming...

i use qgit, which is GTK based and thus uses the native desktop fonts.

	Ingo
