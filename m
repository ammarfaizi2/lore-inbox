Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSE0JWJ>; Mon, 27 May 2002 05:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315223AbSE0JWI>; Mon, 27 May 2002 05:22:08 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:37129 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S315091AbSE0JWI>; Mon, 27 May 2002 05:22:08 -0400
Date: Mon, 27 May 2002 11:22:01 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Clemens Schwaighofer <cs@pixelwings.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.18-dj1 with gcc 3.1 ...
In-Reply-To: <Pine.LNX.4.44.0205271112500.23516-100000@lynx.piwi.intern>
Message-ID: <Pine.LNX.4.33.0205271119550.19994-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, Clemens Schwaighofer wrote:

Hi,

> I just tried to compile 2.5.18-dj1 with gcc 3.1 and it failed with NTFS as
> module:

It is a known problem and already reported to gcc people. AFAIR there is
the problematic change in gcc already found, but I'm not sure if the
problem is fixed in gcc CVS. Anton?

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku


