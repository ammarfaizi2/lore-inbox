Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTBLRX3>; Wed, 12 Feb 2003 12:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTBLRX3>; Wed, 12 Feb 2003 12:23:29 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:30607 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267174AbTBLRX2>;
	Wed, 12 Feb 2003 12:23:28 -0500
Date: Wed, 12 Feb 2003 17:29:05 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for i8042?
Message-ID: <20030212172905.GA18248@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Shawn Starr <spstarr@sh0n.net>, Adam Belay <ambx1@neo.rr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030212155506.GA13038@codemonkey.org.uk> <Pine.LNX.4.44.0302121114150.211-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302121114150.211-100000@coredump.sh0n.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 11:14:40AM -0500, Shawn Starr wrote:

 > Right but, why does this *not* show up in 2.4? IRQ 12 is free in 2.4 but
 > not in 2.5 *with* PS/2 mouse enabled?!

At a guess CONFIG_PSMOUSE=n
It works fine here.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
