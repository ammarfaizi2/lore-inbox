Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUBXToB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUBXToA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:44:00 -0500
Received: from users.linvision.com ([62.58.92.114]:29128 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262412AbUBXTn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:43:59 -0500
Date: Tue, 24 Feb 2004 20:43:54 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Timothy Miller <miller@techsource.com>
Cc: John Heil <kerndev@sc-software.com>,
       Thomas Zehetbauer <thomasz@hostmaster.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
Message-ID: <20040224194354.GA13816@bitwizard.nl>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org> <20040222025957.GA31813@MAIL.13thfloor.at> <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org> <1077584461.8414.164.camel@hostmaster.org> <Pine.LNX.4.58.0402231707220.13525@scsoftware.sc-software.com> <403B5257.2030305@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403B5257.2030305@techsource.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 08:32:07AM -0500, Timothy Miller wrote:
> Things may have changed, but when I last built a Linux box (Athlon XP 
> 2800+), I was not able to find a motherboard for recent AMD processors 
> with 64bit/66mhz PCI slots.  If I'd needed that, I would have had to go 
> with Intel.

Ehmm. We've been trying to get 64/66 slots in our systems a while, and
the only affordable option I've been able to find are the dual-athlon 
boards (Tyan, Asus). 

We found tons of Intel boards that didn't have them until we figured 
out that the popular Intel chipsets didn't support it....

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
