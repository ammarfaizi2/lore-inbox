Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVAPXiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVAPXiW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVAPXiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:38:22 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61061 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262648AbVAPXiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:38:13 -0500
Subject: Re: MMC Driver RFC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <047701c4fc21$a1579b50$0f01a8c0@max>
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max>
	 <20050112214345.D17131@flint.arm.linux.org.uk>
	 <023c01c4f8f3$1d497030$0f01a8c0@max>
	 <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com>
	 <41E7AF11.6030005@drzeus.cx> <41E7DD5E.5070901@f2s.com>
	 <41EA5C8D.8070407@drzeus.cx> <41EA69F0.5060500@f2s.com>
	 <41EAC3FD.1070001@drzeus.cx>  <047701c4fc21$a1579b50$0f01a8c0@max>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105914799.12196.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 22:33:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-16 at 23:17, Richard Purdie wrote:
> On the subject of patents, the whole idea behind SD is that there aren't 
> patents as for a patent to exist, we'd have some publicly available 
> information on how SD works. We're not breaking any copyrights as I nobody 
> involved with this code has see any code to copy from.
> 
> So in short, I can't see any reason we can't put the code we have into the 
> kernel...

Given that companies like Intel have been published the SD
initialisation sequences since 2002 and nobody has taken any action I
can't see this as being credibly a trade secret or obtained maliciously.
Nor does the document state anything is secret.

See Intel app note 278533-001 "Using SDCard and SDIO with Intel (r)
PXA250 Applications Processor MMC Controller" 

http://www.intel.com/design/pca/applicationsprocessors/applnots/278533-001.htm

If there were any secrets the owners appear to have failed to take any
action neccessary to defend them.

Alan

