Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSENN01>; Tue, 14 May 2002 09:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSENN00>; Tue, 14 May 2002 09:26:26 -0400
Received: from p5087D6B1.dip.t-dialin.net ([80.135.214.177]:15970 "EHLO
	extern.linux-systeme.org") by vger.kernel.org with ESMTP
	id <S315717AbSENN0Z>; Tue, 14 May 2002 09:26:25 -0400
Date: Tue, 14 May 2002 15:26:15 +0200 (MET DST)
From: mcp@linux-systeme.de
To: Masaru Kawashima <masaruk@gol.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmwarefb 0.5.0
In-Reply-To: <20020514222024.4b18a826.masaruk@gol.com>
Message-ID: <Pine.LNX.3.96.1020514152442.32207A-100000@fps>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masaru,

> > diff -uraN linux-2.4.19-pre8/include/linux/fb.h linux/include/linux/fb.h
> > --- linux-2.4.19-pre8/include/linux/fb.h	Tue May 14 05:11:14 2002
> > +++ linux/include/linux/fb.h	Tue May 14 01:24:06 2002
> > @@ -96,6 +96,8 @@
> >  #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
> >  #define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon family		*/
> >  
> > +#define FB_ACCEL_VMWARE_SVGA	50	/* VMware Virtual SVGA Graphics */
> > +#define FB_ACCE
> > ^ ^ ^ Where is the rest? :) Looks like incomplete. Or is it only one add?
> 
> Take a look at following URLs.
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=102134726119425&w=2
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=102134726119425&q=p3
Could you please take a look at it?! ;) ... Its missing there. Or all my
browsers are broken and even wget is broken.

Its the end of the patch!

ciao, Marc

