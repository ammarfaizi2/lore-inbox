Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270091AbTGNN7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270086AbTGNN7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:59:31 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:61956 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270091AbTGNN5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:57:38 -0400
Subject: Re: 2.6.0-test1: Hang during boot on Intel D865PERL motherboard
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Paul Nasrat <pauln@truemesh.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030714110335.GQ28359@raq465.uk2net.com>
References: <20030714110311.6059.qmail@linuxmail.org>
	 <20030714110335.GQ28359@raq465.uk2net.com>
Content-Type: text/plain
Message-Id: <1058191943.588.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Jul 2003 16:12:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 13:03, Paul Nasrat wrote:
> On Mon, Jul 14, 2003 at 12:03:11PM +0100, Felipe Alfaro Solana wrote:
> > Hi,
> > 
> > I've compiled linux-2.6.0-test1 kernel with the attached "config" file. When trying to boot the kernel, it hangs on "Uncompress Linux kernel...OK". The system is:
> 
> You only have the dummy console selected ensuring you have:
> 
> CONFIG_CONSOLE_VGA=y
> 
> Should display things to screen.

Yeah! I'm stupid... I forgot to check that. Thanks :-)

