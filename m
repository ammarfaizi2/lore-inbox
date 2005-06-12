Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVFLLRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVFLLRU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVFLLRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:17:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26124 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261937AbVFLLRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:17:09 -0400
Date: Sun, 12 Jun 2005 13:16:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       subbie subbie <subbie_subbie@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: optional delay after partition detection at boot time
Message-ID: <20050612111659.GH28759@alpha.home.local>
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com> <20050612071213.GG28759@alpha.home.local> <Pine.LNX.4.62.0506121225170.11197@numbat.sonytel.be> <20050612110539.GA9765@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612110539.GA9765@gallifrey>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 12:05:39PM +0100, Dr. David Alan Gilbert wrote:
> * Geert Uytterhoeven (geert@linux-m68k.org) wrote:
> 
> > Or make the kernel print /proc/partitions when it is unable to mount root?
> 
> I posted a patch in February to do this:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110946077026065&w=2

This is even better ! I will probably backport it to 2.4 to merge in my
kernels ;-)

thanks,
Willy

