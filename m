Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTGHAD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbTGHAD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:03:27 -0400
Received: from www.wireboard.com ([216.151.155.101]:63636 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S265127AbTGHAD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:03:26 -0400
To: Andi Kleen <ak@suse.de>
Cc: palbrecht@qwest.net, niv@us.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: question about linux tcp request queue handling
References: <3F08858E.8000907@us.ibm.com.suse.lists.linux.kernel>
	<001a01c3441c$6fe111a0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F08B7E2.7040208@us.ibm.com.suse.lists.linux.kernel>
	<000d01c3444f$e6439600$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<3F090A4F.10004@us.ibm.com.suse.lists.linux.kernel>
	<001401c344df$ccbc63c0$6801a8c0@oemcomputer.suse.lists.linux.kernel>
	<p73fzliqa91.fsf@oldwotan.suse.de>
	<m3brw6rn3m.fsf@varsoon.wireboard.com>
	<20030708015201.4a5ad7e6.ak@suse.de>
From: Doug McNaught <doug@mcnaught.org>
Date: 07 Jul 2003 20:17:57 -0400
In-Reply-To: Andi Kleen's message of "Tue, 8 Jul 2003 01:52:01 +0200"
Message-ID: <m31xx1swga.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On 07 Jul 2003 18:25:17 -0400
> Doug McNaught <doug@mcnaught.org> wrote:
> 
> > And furthermore, IIRC, the current Linux networking code is not
> > Berkeley-derived, though an earlier version was.
> 
> The linux network stack was never BSD derived in any way.
> 
> [there are two header files that came from net2, but they do not 
> contain any code]

OIDNRC, thanks for the correction.   :)

Although, I distinctly remember seeing "Net-2" in one of the boot
mesages in an early kernel (pre 1.0); was that just the header files'
doing?

-Doug
