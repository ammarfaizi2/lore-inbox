Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTKPWTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 17:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTKPWTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 17:19:31 -0500
Received: from starsphere.linkinnovations.com ([203.94.138.50]:30336 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263135AbTKPWTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 17:19:30 -0500
Date: Mon, 17 Nov 2003 09:18:41 +1100
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, prakashpublic@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Message-ID: <20031116221840.GA524@zip.com.au>
References: <20031116192643.GB15439@zip.com.au> <3FB7DCF9.5090205@gmx.de> <20031116134231.763fc5ed.akpm@osdl.org> <20031116220630.GD18416@conectiva.com.br> <20031116141342.54a79e32.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116141342.54a79e32.akpm@osdl.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 02:13:42PM -0800, Andrew Morton wrote:
> Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
> > Em Sun, Nov 16, 2003 at 01:42:31PM -0800, Andrew Morton escreveu:
> > > "Prakash K. Cheemplavam" <prakashpublic@gmx.de> wrote:
> > > > CaT wrote:
> > > > 
> > > >  > I just noticed major interactivity problems whilst ogging one of my
> > > 
> > > "ogging"?
> > 
> > To Ogg: to oggify, to convert some digital sound file to the .ogg format
> 
> This much I know.  But it's not exactly a tightly defined and repeatable
> workload.  Oh well.

I can't do much testing atm but the similar symptoms happen whilst running
Heroes3 which tends to suck CPU so I think mp3 encoding would work just 
aswell or anything else that sucks all the CPU it can.

Prakash also reported similar problems whilst compiling the kernel. This is
something I can duplicate also. As my kernel compiles the system can't
even keep up with my typing.

-- 
  From the people who brought you burnt villages in Vietnam...

      http://news.independent.co.uk/world/middle_east/story.jsp?story=452375
