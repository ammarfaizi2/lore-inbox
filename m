Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVGZVn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVGZVn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVGZVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:42:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262064AbVGZVj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:39:59 -0400
Date: Tue, 26 Jul 2005 14:41:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: mkrufky@m1k.net
Cc: astralstorm@gorzow.mm.pl, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
Message-Id: <20050726144149.0dc7b008.akpm@osdl.org>
In-Reply-To: <42E69C5B.80109@m1k.net>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
	<42E692E4.4070105@m1k.net>
	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
	<42E69C5B.80109@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> [ tracking mm stuff ]
>

Sigh, sorry.  It's hard.  -mm is always in flux.  I no longer send out the
`patch was dropped' message because it disturbs people.  The mm-commits
list does not resend a patch when it is changed (other patches folded into
it, rejects fixed, changelog updated, rediffed, etc).  Sometimes I'll
comment out a patch but not fully drop it.  I pull all the git trees at
least twice a day and that's not reflected on the mm-commits list either.

You can always tell when a -mm release is coming by watching the shower of
stupid compile fixes emerging :(

I spose I could emit a broken-out.tar.gz file occasionally (it'd be up to 5
times a day), but there's no guarantee that it'll compile, let alone run. 
I could also send a notification to mm-commits when I do so.  Would that
help?
