Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993116AbWJUReJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993116AbWJUReJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993117AbWJUReJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:34:09 -0400
Received: from solarneutrino.net ([66.199.224.43]:60687 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S2993116AbWJUReI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:34:08 -0400
Date: Sat, 21 Oct 2006 13:34:02 -0400
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, Aleksey Gorelov <dared1st@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
Message-ID: <20061021173402.GA30750@tau.solarneutrino.net>
References: <20061017180003.GB24789@tau.solarneutrino.net> <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com> <20061017222727.GB24891@tau.solarneutrino.net> <45390E09.7050508@intel.com> <20061020180610.GA17675@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061020180610.GA17675@mail.muni.cz>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 08:06:10PM +0200, Lukas Hejtmanek wrote:
> On Fri, Oct 20, 2006 at 10:57:29AM -0700, Auke Kok wrote:
> > To all that are seeing this problem:
> > 
> > can you send me (off-list is OK) the motherboard number+name, the BIOS 
> > versions (+ where you downloaded them from) that you have tried and for 
> > each version, whether it worked without this workaround or not?
> 
> Three days ago, Intel released a new BIOS version that claims to fix
> this issue.
> 
> I've tested it with 2.6.18 kernel which was unable to restart, it
> works now so it seems that fix was successful.

I just tried the 1458 BIOS without the workaround and it's working fine.

Thanks!
-ryan
