Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317821AbSFMUiy>; Thu, 13 Jun 2002 16:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317822AbSFMUix>; Thu, 13 Jun 2002 16:38:53 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:38122
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317821AbSFMUix>; Thu, 13 Jun 2002 16:38:53 -0400
Date: Thu, 13 Jun 2002 13:38:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Paul P Komkoff Jr <i@stingr.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7xxx won't compile w/o PCI at all <- fixed
Message-ID: <20020613203842.GW13541@opus.bloom.county>
In-Reply-To: <20020613194636.GA26527@stingr.net> <200206132027.g5DKR4968416@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 02:27:04PM -0600, Justin T. Gibbs wrote:
> >I know I shouldn't do that
> >I also know someone should do at least compile on cases which affected by
> >some patch.
> 
> I guess I'm missing some context here.
> 
> The patch, on first inspection, appears correct.  Unfortunately, finding
> machines without PCI busses is getting more and more difficult every day,
> but I'll add a build case that disables PCI busses so we catch these kinds
> of failures in the future..

Well, without a PCI bus and an onboard aic7xxx controller maybe...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
