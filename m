Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUDPOZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 10:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUDPOZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 10:25:34 -0400
Received: from mail.cyclades.com ([64.186.161.6]:32984 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263203AbUDPOZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 10:25:33 -0400
Date: Fri, 16 Apr 2004 10:53:51 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
Message-ID: <20040416135351.GC1485@logos.cnet>
References: <20040415171755.GC3218@logos.cnet> <Pine.LNX.4.10.10404160227080.22035-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10404160227080.22035-100000@master.linux-ide.org>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 02:29:16AM -0700, Andre Hedrick wrote:
> 
> Marcelo,
> 
> To be RUDELY BLUNT!  When in the hell did it matter in the past?
> 
> Recall your failure to include ATA133 and SATA 1.0 back in 2.4.16-19.

ATA133 was merged by Alan Cox in 2.4.21. SATA 1.0 was posted by Jeff in the past, 
but I preferred to hold it for a while (to make sure its more stable).

It now seems Jeff is more confident with it.

> I actually object to it on the sheer principle of past history.

This is a special case. I dont see any good arguments to not merge it 
from you.

