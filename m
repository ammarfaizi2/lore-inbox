Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWHMVgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWHMVgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWHMVgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:36:49 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:49928 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751517AbWHMVgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:36:49 -0400
Message-ID: <44DF9B6C.8000902@superbug.co.uk>
Date: Sun, 13 Aug 2006 22:36:44 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.5 (X11/20060730)
MIME-Version: 1.0
To: Henti Smith <henti@geekware.co.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: upgrading pentavalue drivers from 2.4 to 2.6
References: <20060813142711.2cccf6c3@yoda.foad.za.net>
In-Reply-To: <20060813142711.2cccf6c3@yoda.foad.za.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henti Smith wrote:
> Hi guys, 
> 
> I have a client that uses pentavalue DVB-S cards pretty much all over
> their business, however the drivers has not been updated since 2002
> (2.4 kernel only) I've spoken to the dev's at the company and they are
> not interested in doing drivers for 2.6
> 
> The 2.4 drivers they released is source code format, however I could
> not find any clear indication of licence agreements to use the code for
> further development. 
> 
> I'm hoping that it's GPL'ed since MODULE_LICENSE("GPL"); appears in the
> pentadrv.c and scanval.c files
> 
> I'm going to contact them again to confirm we can use the code for
> 2.4 to upgrade to 2.6 and possible include in the kernel source (if it
> will be allowed :P) 
> 
> Lastly .. and the reason I'm mailing is .. I'm looking for somebody
> that is keen on  doing the port .. I'll happily supply hardware (we
> have lots of these cards) 
> 
> beer or other incentives can be negotiated ;P 
> 
> Thanks :) 
> 

They are binary only drivers. I.e. A group of .o files with .c wrappers.
So no way to port them to 2.6

James

