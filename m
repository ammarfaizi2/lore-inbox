Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263066AbUJ1Nd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbUJ1Nd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbUJ1NdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:33:25 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26807 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S263061AbUJ1NdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:33:02 -0400
Date: Thu, 28 Oct 2004 15:32:57 +0200 (CEST)
From: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>
X-X-Sender: asklein@pluto.physik.uni-wuerzburg.de
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
Cc: Andi Kleen <ak@muc.de>, Andrew Walrond <andrew@walrond.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: solution Re: lost memory on a 4GB amd64
In-Reply-To: <Pine.LNX.4.58.0410271809090.10573@fb07-2go.math.uni-giessen.de>
Message-ID: <Pine.LNX.4.58.0410281522060.3903@pluto.physik.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
 <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de>
 <Pine.LNX.4.58.0410231220400.17491@fb07-2go.math.uni-giessen.de>
 <20041023164902.GB52982@muc.de> <Pine.LNX.4.58.0410241133400.17491@fb07-2go.math.uni-giessen.de>
 <Pine.LNX.4.58.0410271704050.3903@pluto.physik.uni-wuerzburg.de>
 <Pine.LNX.4.58.0410271718050.10573@fb07-2go.math.uni-giessen.de>
 <Pine.LNX.4.58.0410271751330.3903@pluto.physik.uni-wuerzburg.de>
 <Pine.LNX.4.58.0410271809090.10573@fb07-2go.math.uni-giessen.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on domino1/uni-wuerzburg(Release 6.51HF561 | September
 17, 2004) at 10/28/2004 15:32:56,
	Serialize by Router on domino1/uni-wuerzburg(Release 6.51HF561 | September
 17, 2004) at 10/28/2004 15:32:57,
	Serialize complete at 10/28/2004 15:32:57
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,


On Wed, 27 Oct 2004, Sergei Haller wrote:

> On Wed, 27 Oct 2004, Andreas Klein (AK) wrote:
> 
> AK> Additionaly there are some other problems that only occur, when the 
> AK> modules are installed one pair for each CPU.
> 
> IIRC [I might be wrong], Andrew is running this board (S2885) with exactly
> this memory configuration without problems.

Yes, I have read that. I also have one board running without problems and 
45 boards which have the problem. The running one has been bought over a 
year ago. The 45 boards which are not running have been bought a few weeks 
ago.
So I think they have made a bad change to the board design since the 
prototype board which is running perfect or there is a bug in the CPUs 
(maybe memory controller, or hypertransport). In the running board CPUs 
with stepping 1 are installed, the not running ones have CPU stepping 10.

Bye,

-- Andreas Klein
   asklein@cip.physik.uni-wuerzburg.de
   root / webmaster @cip.physik.uni-wuerzburg.de
   root / webmaster @www.physik.uni-wuerzburg.de
_____________________________________
|                                   | 
|   Long live our gracious AMIGA!   |
|___________________________________|

