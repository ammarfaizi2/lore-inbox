Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271090AbTGPT6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271099AbTGPT6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:58:07 -0400
Received: from tazz.wtf.dk ([80.199.6.58]:1664 "EHLO sokrates")
	by vger.kernel.org with ESMTP id S271090AbTGPT6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:58:05 -0400
Date: Wed, 16 Jul 2003 22:13:39 +0200
From: Michael Kristensen <michael@wtf.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test1-ac2
Message-ID: <20030716201339.GA618@sokrates>
References: <200307161816.h6GIGKH09243@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200307161816.h6GIGKH09243@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@redhat.com> [2003-07-16 21:29:13]:
> 2.6.0-test1-ac2
> o	EMU10K update to match CVS + fixes		(Rudo Thomas)
Yes, this made my oops on module-load go away.

Apropos emu10k1. Why is OSS deprecated? I have tried a little to get
ALSA working, but it doesn't seem to work. Hint?

By the way, Alan Cox. I think you forgot to increment the ac1 to ac2
somewhere.

-- 
Med Venlig Hilsen/Best Regards/Mit freundlichen Grüßen
Michael Kristensen <michael@wtf.dk>
