Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285730AbRLHBX3>; Fri, 7 Dec 2001 20:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285724AbRLHBXV>; Fri, 7 Dec 2001 20:23:21 -0500
Received: from [144.137.80.33] ([144.137.80.33]:32240 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S285730AbRLHBXF>;
	Fri, 7 Dec 2001 20:23:05 -0500
Message-ID: <3C1166FE.C03F0597@eyal.emu.id.au>
Date: Sat, 08 Dec 2001 12:03:58 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre6 drm-4.0
In-Reply-To: <4719.1007767953@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On 07 Dec 2001 18:27:11 -0500,
> Robert Love <rml@tech9.net> wrote:
> >On Fri, 2001-12-07 at 18:20, Keith Owens wrote:
> >
> >> How long do people plan to keep drm 4.0 code in their versions of the
> >> kernel?
> >
> >For 2.5, there probably is no intention of keeping that around.  But can
> >we honestly ditch it in the middle of a stable kernel?  Personally I
> >don't use it, but its not polite ...
> 
> Linus ditched drm 4.0 months ago.  It only survives in arch add on
> patches like ia64 and in -ac trees.

Well, I am on Debian stable, and the only Xfree4 contributed packages
are for 4.0.

I will move on to 4.1 when Debian moves on, but as you know they are
slower than a tired snail when it comes to new releases.

I wonder how many other people use these 4.0 packages off:

deb ftp://debian.cri74.org/debian-cri potato/contrib_luis_sismeiro main
non-free

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
