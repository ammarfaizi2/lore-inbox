Return-Path: <linux-kernel-owner+w=401wt.eu-S1754133AbWLRPUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbWLRPUQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbWLRPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:20:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32854 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbWLRPUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:20:14 -0500
Subject: Re: [2.6 patch] remove the broken SCSI_SEAGATE driver
From: Arjan van de Ven <arjan@infradead.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <m3ac1l2u3a.fsf@defiant.localdomain>
References: <20061212162238.GR28443@stusta.de>
	 <1165966274.5903.56.camel@mulgrave.il.steeleye.com>
	 <20061213000902.GD28443@stusta.de> <m3wt4tp9ka.fsf@defiant.localdomain>
	 <1166198454.2846.10.camel@mulgrave.il.steeleye.com>
	 <m3ac1mb88s.fsf@defiant.localdomain>
	 <1166386966.9647.20.camel@mulgrave.il.steeleye.com>
	 <m3tzzu9q7k.fsf@defiant.localdomain>
	 <1166431702.3365.934.camel@laptopd505.fenrus.org>
	 <m3ac1l2u3a.fsf@defiant.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 18 Dec 2006 16:20:10 +0100
Message-Id: <1166455210.3365.1050.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 14:48 +0100, Krzysztof Halasa wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > if a tree falls in a forest but there's nobody around to hear it, does
> > it make a sound?
> >
> > This sort of heisenbug questions aren't solved by "nobody hears it so
> > lets chop down the forest to make houses out of the wood" answers...
> 
> Does that mean you don't want to know which hardware/drivers aren't used
> anymore and which ones are?

it means that IT DOESN'T MATTER.
* If it's entirely unused, we get no bugreports -> there is no problem.
* If it's used but good quality, we get no bugreports -> there is no
problem

we can't distinguish the two. But.. in neither case is there a problem
so why force anything? I know some people don't like Heisenberg
uncertainty, but... personally for me if the effect is the same I
couldn't care less.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

