Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285365AbRLGBpP>; Thu, 6 Dec 2001 20:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285366AbRLGBpF>; Thu, 6 Dec 2001 20:45:05 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:1456 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S285365AbRLGBor>; Thu, 6 Dec 2001 20:44:47 -0500
Date: Thu, 6 Dec 2001 18:44:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011207014439.GE30935@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E16C2HM-0002JR-00@the-village.bc.nu> <20011206180432.IHMU19462.femail37.sdc1.sfba.home.com@there> <20011206195710.A1949@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011206195710.A1949@thyrsus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 07:57:10PM -0500, Eric S. Raymond wrote:
> Rob Landley <landley@trommello.org>:
> > P.S.  Can we seperate "add new subsystem y prime" and "remove old subsystem 
> > y".  LIke the new and old SCSI error handling, which have been in the tree in 
> > parallel for some time?  Did I hear Eric ever suggest removing the old 
> > configurator for 2.4?  Anybody?
> 
> The whole point of putting the new configurator in would be to be able
> to drop the old one out.
> 
> But that would be strictly Marcelo's call.  It would be up to him to decide
> whether the tradeoff were worth it.

Yes, but what people are saying (on this part of the thread) is please
don't bother Marcelo with it in the first place.  All of the main gripes
people have don't apply to the current unstable tree, but most certainly
do to the current stable one.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
