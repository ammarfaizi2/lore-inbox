Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTGHAKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTGHAKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:10:35 -0400
Received: from ns.suse.de ([213.95.15.193]:24580 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264948AbTGHAKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:10:33 -0400
Date: Tue, 8 Jul 2003 02:25:07 +0200
From: Andi Kleen <ak@suse.de>
To: Doug McNaught <doug@mcnaught.org>
Cc: palbrecht@qwest.net, niv@us.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: question about linux tcp request queue handling
Message-Id: <20030708022507.0c9f439b.ak@suse.de>
In-Reply-To: <m31xx1swga.fsf@varsoon.wireboard.com>
References: <3F08858E.8000907@us.ibm.com.suse.lists.linux.kernel>
	<001a01c3441c$6fe111a0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F08B7E2.7040208@us.ibm.com.suse.lists.linux.kernel>
	<000d01c3444f$e6439600$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F090A4F.10004@us.ibm.com.suse.lists.linux.kernel>
	<001401c344df$ccbc63c0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<p73fzliqa91.fsf@oldwotan.suse.de>
	<m3brw6rn3m.fsf@varsoon.wireboard.com>
	<20030708015201.4a5ad7e6.ak@suse.de>
	<m31xx1swga.fsf@varsoon.wireboard.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Jul 2003 20:17:57 -0400
Doug McNaught <doug@mcnaught.org> wrote:


> Although, I distinctly remember seeing "Net-2" in one of the boot
> mesages in an early kernel (pre 1.0); was that just the header files'
> doing?

Net-2 was the name for a linux network code release too. The current code is net4
(actually more net5). But it has nothing to do with the similarly named
BSD release. 

-Andi
