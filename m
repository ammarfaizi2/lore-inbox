Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSJUPXZ>; Mon, 21 Oct 2002 11:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSJUPXY>; Mon, 21 Oct 2002 11:23:24 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:39604 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261395AbSJUPXX>; Mon, 21 Oct 2002 11:23:23 -0400
Subject: Re: What kernels 2.4.x 2.5.x compile gcc3.2???
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: clemens@dwf.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210151849.g9FInbur002088@orion.dwf.com>
References: <200210151849.g9FInbur002088@orion.dwf.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 16:45:08 +0100
Message-Id: <1035215108.27259.165.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-15 at 19:49, clemens@dwf.com wrote:
> The subject just about says it.
> What versions of 2.4.x and 2.5.x compile cleanly with
> the new gcc 3.2 that is included in most recent releases
> (in particular RH8.0)

2.4.18/19/20.. are fine. 2.2 isnt really tested.

> The 2.4.18-14 kernel sources from RH have LOTS of patches,
> and they (well the modules) still dont compile with their
> own config file (sigh).

Works for everyone else 8)

