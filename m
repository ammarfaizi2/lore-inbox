Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTH1QiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTH1QiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:38:19 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:39070 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263782AbTH1QiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:38:18 -0400
Date: Thu, 28 Aug 2003 11:26:30 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org,
       tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030828112630.E639@nightmaster.csn.tu-chemnitz.de>
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030827064301.GF150921@niksula.cs.hut.fi> <20030827110417.GY83336@niksula.cs.hut.fi> <20030827133055.0f7aaf6e.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030827133055.0f7aaf6e.skraw@ithnet.com>; from skraw@ithnet.com on Wed, Aug 27, 2003 at 01:30:55PM +0200
X-Spam-Score: -4.2 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19sPmq-0004d8-00*T1fEfOR2s6k*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 01:30:55PM +0200, Stephan von Krawczynski wrote:
> On Wed, 27 Aug 2003 14:04:17 +0300
> Ville Herva <vherva@niksula.hut.fi> wrote:
> > I don't think vga interferes with anything: I never run X on the box, and
> > even the text console remains quiescent as nothing is logged.
> 
> The thing I ran into once was not really an intensive use of VGA and its ints
> but rather some weird glitches in the boards' int logic that sometimes drove
> the software drivers crazy (was network back then).

I have seen this too, with some DSP board.

But heavy (disk) IO and misterious crashes sound like power problems,
doesn't it?

Regards

Ingo Oeser
