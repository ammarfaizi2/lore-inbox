Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314645AbSD0XiX>; Sat, 27 Apr 2002 19:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314646AbSD0XiW>; Sat, 27 Apr 2002 19:38:22 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:59864 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314645AbSD0XiW>;
	Sat, 27 Apr 2002 19:38:22 -0400
Date: Sun, 28 Apr 2002 01:38:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Ville Herva <vherva@twilight.cs.hut.fi>,
        Martin Bene <martin.bene@icomedias.com>, linux-kernel@vger.kernel.org
Subject: Re: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Message-ID: <20020428013806.A8543@ucw.cz>
In-Reply-To: <20020427173913.A7293@ucw.cz> <Pine.LNX.4.10.10204271434490.15403-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 02:36:07PM -0700, Andre Hedrick wrote:

> On Sat, 27 Apr 2002, Vojtech Pavlik wrote:
> 
> > On Sat, Apr 27, 2002 at 03:55:51PM +0300, Ville Herva wrote:
> > > On Sat, Apr 27, 2002 at 12:16:06PM +0200, you [Martin Bene] wrote:
> > > > 
> > > > IDE: The kernel IDE driver needs to support 48-bit addresseing to support
> > > > 160GB.
> > > > 
> > > > (...) however, you can do something about the linux ATA driver: code
> > > > is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.
> > > 
> > > But which IDE controllers support 48-bit addressing? Not all of them?
> > 
> > ALL IDE controllers support 48-bit addressing. Actually, they don't need
> > to know about it.
> 
> Sorry this is not correct, I have a list that fail.

Care to bless the mailing-list with the names of the chipsets that have
trouble?

> However I need to compose a test to revoke their 48-bit operations
> regardless if the device supports.

If you have a list, then the test is quite easy, ain't it?

-- 
Vojtech Pavlik
SuSE Labs
