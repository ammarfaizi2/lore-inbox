Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbTGGXh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 19:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264753AbTGGXh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 19:37:29 -0400
Received: from ns.suse.de ([213.95.15.193]:42765 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264700AbTGGXh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 19:37:28 -0400
Date: Tue, 8 Jul 2003 01:52:01 +0200
From: Andi Kleen <ak@suse.de>
To: Doug McNaught <doug@mcnaught.org>
Cc: palbrecht@qwest.net, niv@us.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: question about linux tcp request queue handling
Message-Id: <20030708015201.4a5ad7e6.ak@suse.de>
In-Reply-To: <m3brw6rn3m.fsf@varsoon.wireboard.com>
References: <3F08858E.8000907@us.ibm.com.suse.lists.linux.kernel>
	<001a01c3441c$6fe111a0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F08B7E2.7040208@us.ibm.com.suse.lists.linux.kernel>
	<000d01c3444f$e6439600$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F090A4F.10004@us.ibm.com.suse.lists.linux.kernel>
	<001401c344df$ccbc63c0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<p73fzliqa91.fsf@oldwotan.suse.de>
	<m3brw6rn3m.fsf@varsoon.wireboard.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Jul 2003 18:25:17 -0400
Doug McNaught <doug@mcnaught.org> wrote:

> And furthermore, IIRC, the current Linux networking code is not
> Berkeley-derived, though an earlier version was.

The linux network stack was never BSD derived in any way.

[there are two header files that came from net2, but they do not 
contain any code]

-Andi
