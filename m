Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312803AbSDKTG2>; Thu, 11 Apr 2002 15:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312828AbSDKTG1>; Thu, 11 Apr 2002 15:06:27 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:47825 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312803AbSDKTGZ>;
	Thu, 11 Apr 2002 15:06:25 -0400
Date: Thu, 11 Apr 2002 21:06:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: john@antefacto.com, linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020411210606.A15783@ucw.cz>
In-Reply-To: <20020411170910.GS612@gallifrey> <20020411191339.B15435@ucw.cz> <20020411174941.GC17962@antefacto.com> <20020411.195921.730560311.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 07:59:21PM +0200, Rene Rebe wrote:
> On: Thu, 11 Apr 2002 17:49:42 +0000,
>     "John P. Looney" <john@antefacto.com> wrote:
> > On Thu, Apr 11, 2002 at 07:13:39PM +0200, Vojtech Pavlik mentioned:
> > > > I'd presumed this was
> > > > the whole point of the busid spec in the config file.
> > > No, it's for running one Xserver on multiple displays at once only.
> > > Sad, ain't it?
> > 
> >  Very sad. Nice to know it's not really the kernel's fault. 
> 
> It IS the kernel's fault, because only one VT can be active. The
> kernel VT stuff needs to be redesigned to hadle multiple VT at the
> same time ...

Yes and no. You shouldn't need VTs to run Xservers at all.

-- 
Vojtech Pavlik
SuSE Labs
