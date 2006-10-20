Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992560AbWJTSGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992560AbWJTSGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992577AbWJTSGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:06:12 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:61146 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S2992560AbWJTSGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:06:11 -0400
Date: Fri, 20 Oct 2006 20:06:10 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Ryan Richter <ryan@tau.solarneutrino.net>,
       Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
Message-ID: <20061020180610.GA17675@mail.muni.cz>
References: <20061017180003.GB24789@tau.solarneutrino.net> <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com> <20061017222727.GB24891@tau.solarneutrino.net> <45390E09.7050508@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45390E09.7050508@intel.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 81.31.45.161
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 10:57:29AM -0700, Auke Kok wrote:
> To all that are seeing this problem:
> 
> can you send me (off-list is OK) the motherboard number+name, the BIOS 
> versions (+ where you downloaded them from) that you have tried and for 
> each version, whether it worked without this workaround or not?

Three days ago, Intel released a new BIOS version that claims to fix this issue.

I've tested it with 2.6.18 kernel which was unable to restart, it works now so
it seems that fix was successful.

-- 
Luká¹ Hejtmánek
