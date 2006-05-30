Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWE3FUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWE3FUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 01:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWE3FUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 01:20:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45036 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932115AbWE3FUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 01:20:17 -0400
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
From: Arjan van de Ven <arjan@infradead.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
References: <20060529212109.GA2058@elte.hu>
	 <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 07:20:12 +0200
Message-Id: <1148966412.2877.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 00:28 +0200, Michal Piotrowski wrote:
> On 29/05/06, Ingo Molnar <mingo@elte.hu> wrote:
> > We are pleased to announce the first release of the "lock dependency
> > correctness validator" kernel debugging feature, which can be downloaded
> > from:
> >
> >   http://redhat.com/~mingo/lockdep-patches/
> >
> [snip]
> 
> I get this while loading cpufreq modules

can you enable CONFIG_KALLSYMS_ALL ? that will give a more accurate
debug output...

