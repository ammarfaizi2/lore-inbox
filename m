Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSDJFxT>; Wed, 10 Apr 2002 01:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSDJFxT>; Wed, 10 Apr 2002 01:53:19 -0400
Received: from unixbox.com ([207.211.45.65]:56581 "EHLO shell.unixbox.com")
	by vger.kernel.org with ESMTP id <S312457AbSDJFxS>;
	Wed, 10 Apr 2002 01:53:18 -0400
Date: Tue, 9 Apr 2002 23:04:10 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Peter Horton <pdh@berserk.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radeon frame buffer driver
In-Reply-To: <20020410001249.GA2010@berserk.demon.co.uk>
Message-ID: <Pine.BSF.4.44.0204092300400.1932-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the patch, I'll review it this week and probably merge some of
the fixes into my local version and update the driver sometime next week.


ani


On Wed, 10 Apr 2002, Peter Horton wrote:

> Another installment of the Radeon frame buffer driver patch (still
> against 2.4.19-pre2).
>
> * All colour modes > 8bpp are now DIRECTCOLOR (Geert inspired).
>
> * Driver now uses 'ypan' to speed up scrolling even further.
>
> * Fix CRTC pitch to match accelerator pitch (800x600x256 works again).
>
> Driver seems okay now, plays nicely with X etc. etc. Please test if you
> can
>
> P.
>


