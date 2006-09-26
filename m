Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWIZUFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWIZUFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWIZUFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:05:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932259AbWIZUFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:05:54 -0400
Date: Tue, 26 Sep 2006 13:05:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Tobias Oed" <tobiasoed@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk,
       sshtylyov@ru.mvista.com
Subject: Re: enable-cdrom-dma-access-with-pdc20265_old.patch
Message-Id: <20060926130530.5ac89c91.akpm@osdl.org>
In-Reply-To: <BAY105-F11E6F724B96A5A607106EAA3260@phx.gbl>
References: <BAY105-F11E6F724B96A5A607106EAA3260@phx.gbl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 10:43:57 -0400
"Tobias Oed" <tobiasoed@hotmail.com> wrote:

> If it makes things easier my patch labeled
> enable-cdrom-dma-access-with-pdc20265_old.patch in -mm
> could be dropped in favour of what follows (against 2.6.18),
> making the feature an EXPERIMENTAL config option.

eh, we'll just merge it as-is, see what happens, I think.

I'll assume that this new patch contained no other changes (ie: the patch
in -mm is ok-to-merge).

