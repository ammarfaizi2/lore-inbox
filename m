Return-Path: <linux-kernel-owner+w=401wt.eu-S1030499AbXAMAmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbXAMAmm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbXAMAmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:42:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39961 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030499AbXAMAml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:42:41 -0500
Subject: Re: [patch] Fix bttv and friends on 64bit machines with lots of
	memory.
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: hermann pitton <hermann-pitton@arcor.de>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1168472507.3118.7.camel@pc08.localdom.local>
References: <45A4AAA4.4040606@novell.com>
	 <1168472507.3118.7.camel@pc08.localdom.local>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 12 Jan 2007 22:42:30 -0200
Message-Id: <1168648950.5375.12.camel@areia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2007-01-11 às 00:41 +0100, hermann pitton escreveu:
> Am Mittwoch, den 10.01.2007, 09:58 +0100 schrieb Gerd Hoffmann:
> >   Hi,
> > 
> > We have a DMA32 zone now, lets use it to make sure the card
> > can reach the memory we have allocated for the video frame
> > buffers.
> > 
> > please apply,
> > 
> >   Gerd
> 
> Hi,
> 
> did anybody already pick up, comment, review Gerd's patch ?
> 
> Walks in into his own home like a stranger ...
> 
> Gerd, THANKS for all you did.
> It was a incredible lot!

Hermann,

I just picked it today. I was out this week due to a physical damage at
the hd on my notebook, were my mailboxes are retrieved. Only today I
have it on a stable condition to return back to activities, successfully
recovering my /home on it.


