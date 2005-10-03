Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVJCASq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVJCASq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 20:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVJCASp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 20:18:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:8600 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932083AbVJCASp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 20:18:45 -0400
Subject: Re: thinkpad suspend to ram and backlight
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jan Spitalnik <lkml@spitalnik.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
In-Reply-To: <20051002233516.GB6035@elf.ucw.cz>
References: <20051002175703.GA3141@elf.ucw.cz>
	 <200510022007.29660.lkml@spitalnik.net> <20051002182354.GA2031@elf.ucw.cz>
	 <1128294674.8267.65.camel@gaston>  <20051002233516.GB6035@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 10:15:32 +1000
Message-Id: <1128298532.8267.73.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 01:35 +0200, Pavel Machek wrote:

> I found that patch with a little help from the list. Unfortunately, it
> makes things worse (not better) on my X32. [There was another
> regression here. With 2.6.8 or so, backlight was off during S3 sleep
> (but chip still running and eating power). With 2.6.14-rc3, not only
> chip is running, but backlight is forced to max to add an insult to
> the injury].

You may have one of those setups with the backlight working backward...

Ben.


