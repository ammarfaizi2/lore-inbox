Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992585AbWJTSIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992585AbWJTSIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992684AbWJTSIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:08:10 -0400
Received: from solarneutrino.net ([66.199.224.43]:30479 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S2992585AbWJTSII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:08:08 -0400
Date: Fri, 20 Oct 2006 14:07:59 -0400
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Aleksey Gorelov <dared1st@yahoo.com>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
Message-ID: <20061020180759.GC29810@tau.solarneutrino.net>
References: <20061017180003.GB24789@tau.solarneutrino.net> <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com> <20061017222727.GB24891@tau.solarneutrino.net> <45390E09.7050508@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45390E09.7050508@intel.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 10:57:29AM -0700, Auke Kok wrote:
> To all that are seeing this problem:
> 
> can you send me (off-list is OK) the motherboard number+name, the BIOS 
> versions (+ where you downloaded them from) that you have tried and for 
> each version, whether it worked without this workaround or not?

I've got an Intel DG965RY with BIOS version 1250.  That's the only BIOS
I've tried (I flashed it first thing when I got the machine), and the
workaround works.

-ryan
