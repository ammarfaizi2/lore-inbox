Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTDVLVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 07:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTDVLVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 07:21:07 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:22193 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263077AbTDVLVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 07:21:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16037.10355.423568.237712@gargle.gargle.HOWL>
Date: Tue, 22 Apr 2003 13:33:07 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix CPU Names in Kconfig
In-Reply-To: <20030421220715.GA14573@averell>
References: <20030421205520.GA13940@averell>
	<1050955686.13841.0.camel@dhcp22.swansea.linux.org.uk>
	<20030421220715.GA14573@averell>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Mon, Apr 21, 2003 at 10:08:07PM +0200, Alan Cox wrote:
 > > On Llu, 2003-04-21 at 21:55, Andi Kleen wrote:
 > > > OldXeon for the P3 based Xeons is a bit confusing, but we cannot 
 > > > fix the Intel marchitecture here.
 > > 
 > > "Pentium II/III Xeon" v "Pentium IV Xeon"
 > > 
 > > At least thats what ebay user seem to use to distinguish 8)
 > 
 > The reason I didn't do it is that it cannot be easily typed
 > in make oldconfig / make config
 > 
 > (but it probably should offer an numeric menu for these cases I guess...) 
 > 
 > Fixed version for Linus.
 > ...

There were also Pentium II Xeons.
