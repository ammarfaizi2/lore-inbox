Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261879AbSI3AEx>; Sun, 29 Sep 2002 20:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261882AbSI3AEx>; Sun, 29 Sep 2002 20:04:53 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:45766 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261879AbSI3AEw>;
	Sun, 29 Sep 2002 20:04:52 -0400
Date: Mon, 30 Sep 2002 02:10:15 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209300010.CAA02879@harpo.it.uu.se>
To: tmolina@cox.net
Subject: Re: 2.5 Kernel Problem Reports as of 27 Sep
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002 19:54:16 -0500 (CDT), Thomas Molina wrote:
>------------------------------------------------------------------------
>  24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2
>   IDE problems on prePCI                 open               23 Sep 2002
>
>This was reported by Mikael Pettersson <mikpe@csd.uu.se>, but never 
>responded to, and never followed up.  Should this be kept open?

The hang in INIT with 2.5.38 is gone with 2.5.39, but the instant
reboot when I pass the "ide0=qd65xx" kernel option is still there.

/Mikael
