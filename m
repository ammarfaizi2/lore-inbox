Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTAFQ3H>; Mon, 6 Jan 2003 11:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbTAFQ3H>; Mon, 6 Jan 2003 11:29:07 -0500
Received: from www.wireboard.com ([216.151.155.101]:51589 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S267030AbTAFQ3G>; Mon, 6 Jan 2003 11:29:06 -0500
To: Alex Riesen <fork0@users.sf.net>
Cc: Dirk Bull <dirkbull102@hotmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: shmat problem
References: <20030106162251.GA15900@steel>
From: Doug McNaught <doug@mcnaught.org>
Date: 06 Jan 2003 11:36:39 -0500
In-Reply-To: Alex Riesen's message of "Mon, 6 Jan 2003 17:22:51 +0100"
Message-ID: <m3wuligrqg.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <fork0@users.sf.net> writes:

> You have to add SHM_REMAP to shmat flags (see definitions of SHM_ flags).

Hmm, the manpage (on RH7.3 at least) doesn't mention SHM_REMAP.  Nice
to know about it.

-Doug
