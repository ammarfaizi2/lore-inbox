Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSGAWyL>; Mon, 1 Jul 2002 18:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSGAWyK>; Mon, 1 Jul 2002 18:54:10 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:41210
	"EHLO mythical") by vger.kernel.org with ESMTP id <S316577AbSGAWyJ> convert rfc822-to-8bit;
	Mon, 1 Jul 2002 18:54:09 -0400
Date: Mon, 1 Jul 2002 18:56:34 -0400 (EDT)
From: Ryan Anderson <ryan@michonline.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
In-Reply-To: <20020701215718.7762962f.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.10.10207011854100.579-100000@mythical.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Diego Calleja wrote:

> On Mon, 1 Jul 2002 13:48:55 -0400 (EDT)
> Bill Davidsen <davidsen@tmr.com> escribió:
> 
> > Having read some notes on the Ottawa Kernel Summit, I'd like to offer
> > some comments on points raied.
> > 
> > The suggestion was made that kernel module removal be depreciated or
> > removed. I'd like to note that there are two common uses for this
> > capability, and the problems addressed by module removal should be
> > kept in mind. These are in addition to the PCMCIA issue raised.
> 
> And why people wants to remove this nice feature? Only because they
> don't use it, or there's a more profund reason?

Summary from listening to the mp3: It has issues with races that were
only made worse by preempt.

The alternative solution proposed (I forget who mentioned this, though.)
was to allow loading a second module on top of the first.

Those who spoke at the summit will probably want to have the "300 email flame war"
here before this spirals too far. :)



--
Ryan Anderson
  sometimes Pug Majere

