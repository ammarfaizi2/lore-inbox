Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270624AbRHJAPC>; Thu, 9 Aug 2001 20:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270622AbRHJAOm>; Thu, 9 Aug 2001 20:14:42 -0400
Received: from nic-163-c160-146.mn.mediaone.net ([24.163.160.146]:14214 "EHLO
	tweety.localdomain") by vger.kernel.org with ESMTP
	id <S270625AbRHJAOk>; Thu, 9 Aug 2001 20:14:40 -0400
Date: Thu, 9 Aug 2001 19:14:31 -0500 (CDT)
From: "Scott M. Hoffman" <scott@mediaone.net>
X-X-Sender: <scott@tweety.localdomain>
Reply-To: <scott1021@mediaone.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac10
In-Reply-To: <E15UzLL-0008OL-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108091912210.8046-100000@tweety.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001 at 00:35 +0100 Alan Cox wrote:

> > > o Merge DRM for XFree 4.1.x (XFree86 and others)
> > Can I still use my RH7.1 box with X-4.0.3 and ATI DRI?
>
> The -ac tree lets you build either 4.0 or 4.1 DRM - its a config option -
> pick 4.0
> -

 I'm confused?  I'm unable to select the 4.1 option without first
selecting the original DRM option.  Does selecting the 4.1 DRM turn off
the 4.0 code?  Or is this why glxinfo segfaults for me now?

Scott Hoffman


