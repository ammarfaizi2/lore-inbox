Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUJIUrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUJIUrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUJIUrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:47:25 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:34946 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S267417AbUJIUq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:46:59 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: [Patch 1/5] xbox: add 'CONFIG_X86_XBOX' to kernel configuration
User-Agent: KMail/1.7
Cc: Ed Schouten <ed@il.fontys.nl>, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210> <200410091315.10988.lkml@lpbproductions.com> <41684BC1.5000500@ppp0.net>
In-Reply-To: <41684BC1.5000500@ppp0.net>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sat, 9 Oct 2004 13:48:08 -0700
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410091348.09537.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it does go into mainline. What's to stop the inclusion of other gaming 
platforms into the kernel . Say for instance Playstation or Gamecube or some 
other variant. 

matt

On Saturday 09 October 2004 1:36 pm, Jan Dittmer wrote:
> Matt Heler wrote:
> > Why can't theese patches be maintained outside the kernel tree , as it is
> > now ?
> >
> > I'm strongly against this because the X-Box is a gaming platform and last
> > I heard ( and I could be wrong here ) is that you had to hack your X-Box
> > in order to load any other os then the one supplied with it. I just don't
> > see a justified reason why theese patches should be included into the
> > kernel.
>
> <TrollMode>
> Well, Altix is a server platform, last I heard I had to hack my credit
> card institute in order to get one.
> I suspect there are more people using xbox w/ linux than altix users.
> </TrollMode>
>
> Really, Linux already supports so many varieties of hardware used by
> only a small number of people. It's just convenient to have it in
> mainline and adapted when api changes.
>
> Jan
