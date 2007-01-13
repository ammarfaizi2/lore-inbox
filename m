Return-Path: <linux-kernel-owner+w=401wt.eu-S1161167AbXAMBia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbXAMBia (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 20:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbXAMBia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 20:38:30 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:59323 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161167AbXAMBi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 20:38:29 -0500
Subject: Re: [patch] Fix bttv and friends on 64bit machines with lots of
	memory.
From: hermann pitton <hermann-pitton@arcor.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1168648950.5375.12.camel@areia>
References: <45A4AAA4.4040606@novell.com>
	 <1168472507.3118.7.camel@pc08.localdom.local>
	 <1168648950.5375.12.camel@areia>
Content-Type: text/plain; charset=utf-8
Date: Sat, 13 Jan 2007 02:37:33 +0100
Message-Id: <1168652253.4305.60.camel@pc08.localdom.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 12.01.2007, 22:42 -0200 schrieb Mauro Carvalho Chehab:
> Em Qui, 2007-01-11 às 00:41 +0100, hermann pitton escreveu:
> > Am Mittwoch, den 10.01.2007, 09:58 +0100 schrieb Gerd Hoffmann:
> > >   Hi,
> > > 
> > > We have a DMA32 zone now, lets use it to make sure the card
> > > can reach the memory we have allocated for the video frame
> > > buffers.
> > > 
> > > please apply,
> > > 
> > >   Gerd
> > 
> > Hi,
> > 
> > did anybody already pick up, comment, review Gerd's patch ?
> > 
> > Walks in into his own home like a stranger ...
> > 
> > Gerd, THANKS for all you did.
> > It was a incredible lot!
> 
> Hermann,
> 
> I just picked it today. I was out this week due to a physical damage at
> the hd on my notebook, were my mailboxes are retrieved. Only today I
> have it on a stable condition to return back to activities, successfully
> recovering my /home on it.

Mauro, Gerd,

sorry to be a pain with this one,
just thought it could be a missing each other.

Our maintainers don't need to excuse for anything!

Adrian and all, thanks for fixing the remaining bugs.

Cheers,
Hermann




