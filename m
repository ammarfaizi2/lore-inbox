Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSKFO5M>; Wed, 6 Nov 2002 09:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265682AbSKFO5M>; Wed, 6 Nov 2002 09:57:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:15294 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265681AbSKFO5L>;
	Wed, 6 Nov 2002 09:57:11 -0500
Date: Wed, 6 Nov 2002 15:02:52 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, ambx1@neo.rr.com
Subject: Re: yet another update to the post-halloween doc.
Message-ID: <20021106150252.GA6955@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jaroslav Kysela <perex@suse.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ambx1@neo.rr.com
References: <20021106140844.GA5463@suse.de> <Pine.LNX.4.33.0211061526580.573-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211061526580.573-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 03:37:10PM +0100, Jaroslav Kysela wrote:

 > - old ISA PnP code does not require user space tools, too
 > - the new code is mostly based on idea to make behaviour same as for PCI 
 >   devices (probe, remove etc. callbacks) and to merge the PnP BIOS 
 >   access code
 > - maintaince? the code was nearly complete, almost all device drivers were 
 >   converted to support ISA PnP (thus autoconfiguration which has moved to 
 >   the new PnP layer); I don't know what you mean that the code is more 
 >   actively maintained; it was maintained to satisfy my goals 

Ok, I'll make those changes. My apologies for casting the previous
work in such a bad light 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
