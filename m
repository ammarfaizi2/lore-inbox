Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264072AbUD0NSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbUD0NSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 09:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264084AbUD0NSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 09:18:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62380 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264072AbUD0NSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 09:18:43 -0400
Date: Tue, 27 Apr 2004 10:19:41 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Anyone got aic7xxx working with 2.4.26?
Message-ID: <20040427131941.GC10264@logos.cnet>
References: <200404261532.37860.dj@david-web.co.uk> <20040426161004.GE5430@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426161004.GE5430@merlin.emma.line.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 06:10:04PM +0200, Matthias Andree wrote:
> On Mon, 26 Apr 2004, David Johnson wrote:
> 
> > I was wondering if anyone had aic7xxx SCSI working with kernel 2.4.26?
> 
> I've seen bogus and fruitless bus and host adaptor resets at kernel-boot
> with sym53c8xx_2 with a recent 2.4-BK (the last that I could compile, I
> cannot compile the current 2.4 BK tree at all for unknown reasons. 2.6
> is fine), i386.

What is the compile error with 2.4-BK-current? 

Did you post the boot messages with sym53c8xx_2? Can you use sym53c8xx?
> 
> > I've also got the same problem with 2.6.5 (and newer) - but I think this is a 
> > known issue with 2.6?
> 
> Not using aic7xxx on 2.6, 2.6.6-rc2 is fine for me.
