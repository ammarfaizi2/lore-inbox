Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTLHTJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTLHTJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:09:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:3766 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261681AbTLHTJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:09:49 -0500
Date: Mon, 8 Dec 2003 11:09:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Volkov <Andrew.Volkov@transas.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: possible proceses leak
In-Reply-To: <20031208185121.GM8039@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312081109200.13236@home.osdl.org>
References: <2E74F312D6980D459F3A05492BA40F8D0391B0EE@clue.transas.com>
 <20031208185121.GM8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, William Lee Irwin III wrote:
> On Mon, Dec 08, 2003 at 09:45:17PM +0300, Andrew Volkov wrote:
> > Yes.
> > And same bug in kernel/sched.c in ALL *_sleep_on
> > Andrey
>
> Heh, no wonder everyone wants to get rid of the things.

No, they are all correct. No bug here, move along folks, nothing to see..

		Linus
