Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267240AbUBMWKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267243AbUBMWKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:10:24 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:57082 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S267240AbUBMWKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:10:20 -0500
Date: Fri, 13 Feb 2004 15:12:30 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is nForce2 good choice under Linux?
Message-ID: <20040213221230.GA902@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402132048330.31906@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402132048330.31906@alpha.polcom.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 09:10:36PM +0100, Grzegorz Kulewski wrote:
> Hi,
> 
> I am recently considering buying Abit AN7 motherboard with NVIDIA nForce2 
> Ultra 400 with MCP-T bridge.


Short answer:  don't.  Nvidia sucks -- they don't support open source at all.

Longer answer:  You can probably get away with it if you make a good choice with
a board.  Read up specifically on which boards work.

My suggestion, based on experience:   Get a Shuttle AN35N and flash the bios 
to the latest to fix the lockup bug.  It's a $40 board and comes with 5 PCI
slots and 1 AGP.  No firewire or SATA, but if you want them you could now buy
quality, supported PCI cards instead.  This motherboard can run vanilla 2.6.2, 
with nforce IDE, sound and net.  The sound and net nforce drivers need some work
done, so if you don't like how they run you still have lots of PCI slots.  It
doesn't have built on video so you have an option here too.  And you should get 
a good supported ATI card anyway if you want 3d.

I use this board. It is stable, cheap, fast, and fully functional.  Though if I
had a choice to buy a board again, it will not be nvidia.

Jesse
