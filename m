Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWJMVt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWJMVt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWJMVt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:49:26 -0400
Received: from tirith2.ics.muni.cz ([147.251.4.39]:19141 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932078AbWJMVtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:49:25 -0400
Date: Fri, 13 Oct 2006 23:49:22 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
Message-ID: <20061013214922.GL3039@mail.muni.cz>
References: <20061013214029.35732.qmail@web83103.mail.mud.yahoo.com> <20061013214250.GC19608@tau.solarneutrino.net> <20061013214523.GK3039@mail.muni.cz> <20061013214608.GD19608@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061013214608.GD19608@tau.solarneutrino.net>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 81.31.45.161
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 05:46:08PM -0400, Ryan Richter wrote:
> > > >   The similar issue has been discussed in adjacent thread "Machine
> > > >   reboot". Is it Intel motherboard, or just carries Intel chipset ?
> > > >   Does building e1000 driver as a module and 'rmmod e1000' just before
> > > >   reboot help ?
> > > 
> > > It's an Intel DG965RY board.  I'll try out your suggestion on Monday.
> > 
> > Btw, are you using i386 or x86_64 architecture?
> 
> x86_64.

Hm, I'm also using x86_64 and 2.6.19-rc1-git9 works OK for me regardless of
e1000. 2.6.18 hangs if e1000 is built in.

Could you also try exactly 2.6.19-rc1-git9?

-- 
Luká¹ Hejtmánek
