Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWHATcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWHATcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWHATcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:32:19 -0400
Received: from ns2.suse.de ([195.135.220.15]:34248 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751844AbWHATcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:32:18 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
	<20060801013104.f7557fb1.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:32:16 +0200
In-Reply-To: <20060801013104.f7557fb1.akpm@osdl.org>
Message-ID: <p73u04wz1z3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Mon, 31 Jul 2006 10:26:55 +0100
> "Denis Vlasenko" <vda.linux@googlemail.com> wrote:
> 
> > The reiser4 thread seem to be longer than usual.
> 
> Meanwhile here's poor old me trying to find another four hours to finish
> reviewing the thing.

I took a quick look at it and I must say that most of the things
that tripped me up when I first looked at it a long time ago
are gone now.

I guess there could be still quite a lot of cleanup, but it already
looks much better.

-Andi
