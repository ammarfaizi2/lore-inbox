Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263206AbSJIAII>; Tue, 8 Oct 2002 20:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbSJIAII>; Tue, 8 Oct 2002 20:08:08 -0400
Received: from dp.samba.org ([66.70.73.150]:48583 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263206AbSJIAIH>;
	Tue, 8 Oct 2002 20:08:07 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15779.29565.791998.879426@nanango.paulus.ozlabs.org>
Date: Wed, 9 Oct 2002 10:08:29 +1000 (EST)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Input - Make sure input_dev is initialized where needed [23/23]
In-Reply-To: <20021008160319.V18546@ucw.cz>
References: <20021008155045.L18546@ucw.cz>
	<20021008155125.M18546@ucw.cz>
	<20021008155236.N18546@ucw.cz>
	<20021008155651.O18546@ucw.cz>
	<20021008155825.P18546@ucw.cz>
	<20021008155915.Q18546@ucw.cz>
	<20021008160001.R18546@ucw.cz>
	<20021008160100.S18546@ucw.cz>
	<20021008160148.T18546@ucw.cz>
	<20021008160241.U18546@ucw.cz>
	<20021008160319.V18546@ucw.cz>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.
> 'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

It's nice that we get to see the patch, but what would be really nice
is to see the changeset comments that go along with it, which
hopefully explain in a few lines what is being changed and why.  No
doubt the changeset comments are in the gzip_uu part, but that is a
bit opaque.

Thanks,
Paul.
