Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314032AbSDKMaq>; Thu, 11 Apr 2002 08:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314033AbSDKMap>; Thu, 11 Apr 2002 08:30:45 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:28822 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S314032AbSDKMao>;
	Thu, 11 Apr 2002 08:30:44 -0400
Date: Thu, 11 Apr 2002 14:30:34 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: rb_tree methods export request
In-Reply-To: <20020411142447.G14605@dualathlon.random>
Message-ID: <Pine.LNX.4.10.10204111429300.15162-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Only problem is that rb_delete and athers are not exported so that
> > I can't use them in the module.
>  
> You don't need to duplicate the code:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre3aa2/00_rb-export-1
> 
> It is just included in 2.4.19pre6 mainline btw, so just updating to the
> latest kernel should solve your problem with the module.

:) Good news. Thanks a much Andrea
devik

