Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318251AbSGWUcR>; Tue, 23 Jul 2002 16:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSGWUcR>; Tue, 23 Jul 2002 16:32:17 -0400
Received: from ns.suse.de ([213.95.15.193]:12307 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318251AbSGWUbq>;
	Tue, 23 Jul 2002 16:31:46 -0400
Date: Tue, 23 Jul 2002 22:34:56 +0200
From: Dave Jones <davej@suse.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: Markus Pfeiffer <profmakx@profmakx.org>, linux-kernel@vger.kernel.org
Subject: Re: CPU detection broken in 2.5.27?
Message-ID: <20020723223456.C16446@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Patrick Mochel <mochel@osdl.org>,
	Markus Pfeiffer <profmakx@profmakx.org>, linux-kernel@vger.kernel.org
References: <20020723212957.B16446@suse.de> <Pine.LNX.4.44.0207231314390.954-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207231314390.954-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Tue, Jul 23, 2002 at 01:26:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 01:26:38PM -0700, Patrick Mochel wrote:

 > Heh. They've always been there, then. I really did re-add the table from 
 > an older arch/i386/kernel/setup.c ;)
 > 
 > The Celeron detection happens in init_intel(). 

Ah, ok. Then all those cases should magically work..

 > Added. Wait, isn't Foster the one with HT?

AFAIK yes. Don't have one to test with, so can't say for sure.

 > The ones I have say that they 
 > support it, so wouldn't that be a Foster (as well as stepping 5)? 

Which stepping do you have ?
 
 > Updated patch appended. This updated version hasn't been tested, as I
 > don't have any of those processors at my disposal...

-ENOAPPENDAGE.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
